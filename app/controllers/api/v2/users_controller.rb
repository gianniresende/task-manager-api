# frozen_string_literal: true

class Api::V2::UsersController < ApplicationController
  before_action :authenticate_with_token!, only: %i[update destroy]

  def show
    user = User.find(params[:id])
    render json: user, status: 200
  rescue StandardError
    head 404
  end

  def create
    user = User.new(user_params)

    if user.save
      render json: user, status: 201

    else

      render json: { errors: user.errors }, status: 422

    end
  end

  def update
    user = User.find(params[:id])

    if user.update(user_params)
      render json: user, status: 200
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    head 204
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
