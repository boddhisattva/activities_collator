# frozen_string_literal: true

FactoryBot.define do
  factory :web_source do
    sequence(:id, &:to_s)
    sequence(:url) { |n| "http://onedayatatime#{n}" }
    name { 'A random name' }
    scraper { 'OneDayAtATimeScraper' }
  end
end
