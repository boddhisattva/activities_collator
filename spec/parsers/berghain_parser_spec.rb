# frozen_string_literal: true

require 'rails_helper'

describe BerghainParser do
  describe '#extract_all_events_info' do
    context 'Berghain page has events with relevant dates' do
      it 'parses events information and returns an events collection' do
        webpage_document = Nokogiri::HTML(BerghainHtmlHelper.event_with_dates_content)
        berghain_parser = BerghainParser.new

        events = berghain_parser.extract_all_events_info('http://berghain.de/events', webpage_document)

        expect(events.count).to eq 2
        first_event = events.first
        expect(first_event[:title]).to eq('Kisloty')
        expect(first_event[:description]).to eq event_description
        expect(first_event[:start]).to eq(Date.parse('Thu, 26 Mar 2020'))
        expect(first_event[:finish]).to eq(Date.parse('Thu, 26 Mar 2020'))
        expect(first_event[:url]).to eq('http://berghain.de/events/en/event/68453/')
      end
    end
  end
end

def event_description
  "\n    Säule\n  \\n\n    \n    Rune Bagge,\n    \n    \n    Sasha Tsereteli,\n    \n    \n    Sergei German,\n    \n    \n    Textasy\n    \n  "
end
