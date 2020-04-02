# frozen_string_literal: true

require 'rails_helper'

describe CoBerlinParser do
  describe '#extract_all_events_info' do
    let(:co_berlin_parser) { CoBerlinParser.new }

    context 'Co Berlin page has unique events on its page' do
      context 'events have start and end dates' do
        it 'parses events information and returns an events collection' do
          webpage_document = Nokogiri::HTML(CoBerlinHtmlHelper.events_with_start_and_finish_date_content)
          events = co_berlin_parser.extract_all_events_info('https://www.co-berlin.org/en/calender', webpage_document)

          expect(events.count).to eq 2
          first_event = events.first
          expect(first_event[:title]).to eq('Current exhibitions at C/O Berlin')
          expect(first_event[:description]).to eq CoBerlinDataHelper.first_event_with_start_and_finish_date_description
          expect(first_event[:start]).to eq(Date.parse('Sat, 07 Dec 2019'))
          expect(first_event[:finish]).to eq(Date.parse('Sat, 07 Jun 2020'))
          expect(first_event[:url]).to eq('https://www.co-berlin.org/en/calender/en/current-exhibition-co-berlin')
          expect(events.last[:title]).to eq('Linda McCartney')
        end
      end

      context 'event only has start dates' do
        it 'parses event information and returns an events collection' do
          webpage_document = Nokogiri::HTML(CoBerlinHtmlHelper.event_with_start_date_content)
          events = co_berlin_parser.extract_all_events_info('https://www.co-berlin.org/en/calender', webpage_document)

          expect(events.count).to eq 1
          first_event = events.first
          expect(first_event[:title]).to eq('Cancelled – Lecture')
          expect(first_event[:description]).to eq CoBerlinDataHelper.event_with_start_date_description
          expect(first_event[:start]).to eq(Date.parse('Thu, 26 Mar 2020'))
          expect(first_event[:finish]).to eq(Date.parse('Thu, 26 Mar 2020'))
          expect(first_event[:url]).to eq('https://www.co-berlin.org/en/calender/en/events/lecture-abigail-solomon-godeau')
        end
      end
    end
  end
end
