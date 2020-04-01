# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    title { 'Random event title' }
    sequence :url do |n|
      "http://onedayatatime.com/events#{n}"
    end
    start { DateTime.now }
    finish { DateTime.now + 7.days }
    web_source
  end
end
