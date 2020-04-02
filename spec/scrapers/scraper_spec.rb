# frozen_string_literal: true

require 'rails_helper'

describe Scraper do
  describe '#scrape' do
    let(:web_source) { create(:web_source, url: 'https://www.co-berlin.org') }
    let(:parser) { CoBerlinParser.new }
    let(:scraper) { Scraper.new(parser) }

    context 'page contains unique event entries' do
      it 'extracts events info and creates event entries in the database' do
        webpage_document = Nokogiri::HTML(CoBerlinHtmlHelper.events_with_start_and_finish_date_content)
        allow(scraper).to receive(:get_page_data) { webpage_document }
        allow(parser).to receive(:extract_all_events_info).with('https://www.co-berlin.org', webpage_document) do
          CoBerlinDataHelper.events_info
        end

        expect { scraper.scrape(web_source, 'https://www.co-berlin.org/en/calender') }.to change(Event, :count).by(2)
      end
    end

    context 'page contains duplicate event entries' do
      let(:webpage_document) { Nokogiri::HTML(CoBerlinHtmlHelper.duplicate_events) }

      before do
        allow(scraper).to receive(:get_page_data) { webpage_document }
        allow(parser).to receive(:extract_all_events_info).with('https://www.co-berlin.org', webpage_document) do
          CoBerlinDataHelper.duplicate_events_info
        end
      end

      it 'creates unique event entries in the database & discards duplicate ones' do
        expect { scraper.scrape(web_source, 'https://www.co-berlin.org/en/calender') }.to change(Event, :count).by(1)
      end

      it 'captures errors when trying to create duplicate events' do
        errors = scraper.scrape(web_source, 'https://www.co-berlin.org/en/calender')

        expect(errors.count).to eq(1)
        expect(errors.first[:message]).to eq('Error in creating event. Details - Validation failed: Url has already been taken')
        expect(errors.first[:websource]).to eq('https://www.co-berlin.org/en/calender')
      end
    end
  end
end
