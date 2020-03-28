# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'associations' do
    it { should belong_to(:web_source) }
  end

  describe 'validations' do
    let(:web_source_id) { WebSource.create(name: 'believe', url: 'http://believe.com', scraper: 'RandomScraper').id }

    subject do
      Event.new(title: 'Here is the content', start: Time.zone.now.to_datetime, url: 'http://believe.com/event/23',
                finish: Time.zone.now.to_datetime + 1.day, web_source_id: web_source_id)
    end

    it { should validate_uniqueness_of(:url) }
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:start) }
    it { should validate_presence_of(:finish) }
  end
end
