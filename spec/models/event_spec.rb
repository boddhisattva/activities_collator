# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'associations' do
    it { should belong_to(:web_source) }
  end

  describe 'validations' do
    let(:web_source) { create(:web_source) }
    subject(:event) { build(:event, web_source: web_source) }

    it { should validate_uniqueness_of(:url) }
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:start) }
    it { should validate_presence_of(:finish) }
  end

  describe '.search_by' do
    context 'given certain search filter criteria' do
      it 'gets results based on the specified search criteria' do
        web_source = create(:web_source)
        4.times.map { |i| create :event, title: "Random event title #{i}", web_source: web_source }
        filtering_params = { 'title' => '  Random event   title  2  ', 'start' => 1.week.ago.strftime('%m/%d/%Y'),
                             'finish' => 2.weeks.from_now.strftime('%m/%d/%Y'), 'web_source_id' => web_source.id }

        events = Event.search_by(filtering_params)

        expect(events.first.title).to eq('Random event title 2')
      end
    end
  end
end
