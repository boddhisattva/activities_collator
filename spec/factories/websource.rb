# frozen_string_literal: true

FactoryBot.define do
  factory :web_source do
    sequence(:url) { |n| "http://onedayatatime#{n}" }
    name { 'A random name' }
  end
end
