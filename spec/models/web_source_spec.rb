# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WebSource, type: :model do
  describe 'associations' do
    it { should have_many(:events).dependent(:destroy) }
  end

  describe 'validations' do
    subject { WebSource.new(name: 'test', url: 'http://test.com', scraper: 'RandomScraper') }

    it { should validate_uniqueness_of(:url) }
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:scraper) }
  end
end
