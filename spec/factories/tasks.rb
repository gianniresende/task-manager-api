# frozen_string_literal: true

FactoryBot.define do
  factory :task do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    deadline { Faker::Date.forward }
    done false
    # user_id '1'
    user
  end
end
