# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    # username Faker::Name.first_name.downcase
    password '123457'
    password_confirmation '123457'
    # first_name Faker::Name.first_name
    # last_name Faker::Name.last_name
    # active true
    # confirmed true
  end
end
