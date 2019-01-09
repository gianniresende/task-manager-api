# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let!(:user) { create(:user) }
  let(:user_id) { user.id }

  before { host! 'api.taskmanager.test' }

  describe 'GET /users/:id' do
    before do
      get "/users/#{user_id}", params: {}, headers: headers
    end

    context 'when the user exists' do
      it 'returns the user' do
        expect(json_body[:id]).to eq(user_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the user does not exist' do
      let(:user_id) { 10_000 }

      it 'returns status coide 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'POST /users' do
    before do
      header = {'Accept' => 'application/vnd.taskmanager.v1'}
      post '/users', params: { user: user_params}, headers: headers
    end

    context 'when the request params are valid' do
      let(:user_params) { FactoryBot.attributes_for(:user)}

      it 'return status code 201' do
        expect(response).to have_http_status(201)
      end

      it 'returns json data for the created user' do
        user_response = JSON.parse(response.body)
        expect(user_response['email']).to eq(user_params[:email])
      end
    end

    context 'when the request params are invalid' do

      let(:user_params) { FactoryBot.attributes_for(:user, email: 'invalid_email@')}

      it 'return status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns the json data for the erros' do
          user_response = JSON.parse(response.body)
        expect(user_response).to have_key('errors') 
      end      
    end

  end

  describe 'PUT /users/:id' do
    before do
      headers = {'Accept' => 'application/vnd.taskmanager.v1'}
      put "/users/#{user_id}", params: { user: user_params }, headers: headers
    end

    context 'when the request params are valid' do
      let(:user_params) { { email: 'newemail@taskmanager.com' } }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the data for the updated user' do
        user_response  = JSON.parse(response.body, symbolize_names: true)
        expect(user_response[:email]).to eq(user_params[:email])
      end
    end

    context 'when the request params are invalid' do
      let(:user_params) { { email: 'invalid_email@' } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns the json data for the erros' do
        user_response = JSON.parse(response.body)
        expect(user_response).to have_key('errors') 
      end     
    end
  end


end