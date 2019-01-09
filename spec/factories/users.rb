# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    username Faker::Name.first_name.downcase
    password 'Sample:1'
    password_confirmation 'Sample:1'
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    active true
    confirmed true
  end
end
