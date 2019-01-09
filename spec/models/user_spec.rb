# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  #before { @user = FactoryBot.build(:user) }
  let(:user) { build(:user) }

  #it { expect(@user).to respond_to(:email) }
  # pending "add some examples to (or delete) #{__FILE__}"

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_confirmation_of(:password) }
  it { is_expected.to allow_value('costa@nonato.com').for(:email) }
  it { is_expected.to validate_uniqueness_of(:auth_token) }

  describe '#info' do
    it 'returns email, created_at and a Token' do
      user.save!
      #allow(Devise).to receive(:friendly_token).and_return('abc123xyzTOKEN')

      expect(user.info).to eq("#{user.email} - #{user.created_at}")
    end
  end
end
