# frozen_string_literal: true

require 'rails_helper'

describe Scraper do
  describe '#scrape' do
    let(:web_source) { create(:web_source) }
    let(:new_scraper) { BrandNewScraper.new }

    context 'event URL not defined in the subclass' do
      it 'raises a NotImplementedError with an appropriate error message' do
        expect { new_scraper.scrape(web_source) }.to raise_error(NotImplementedError, 'An event URL needs to be present in a subclass')
      end
    end

    context 'page specific parser method(e.g., events) is not defined in the subclass' do
      it 'raises a NotImplementedError with an appropriate error message' do
        scraper_without_parser_methods = ScraperWithoutParserMethods.new

        allow(scraper_without_parser_methods).to receive(:parse_html_document) do
          Nokogiri::HTML(ScraperWithoutParserMethodsHtmlHelper.events_content)
        end

        expect { scraper_without_parser_methods.scrape(web_source) }.to raise_error(NotImplementedError, 'The events method needs to be implemented in a subclass of BaseScraper')
      end
    end

    context 'page contains duplicate event entries' do
      it 'creates unique event entries in the database & discards duplicate ones' do
        scraper = CoBerlinParser.new
        allow(scraper).to receive(:parse_html_document) do
          Nokogiri::HTML(CoBerlinHtmlHelper.duplicate_events)
        end

        expect { scraper.scrape(web_source) }.to change(Event, :count).by(1)
      end

      it 'captures errors when trying to create duplicate events' do
        scraper = BerghainParser.new
        allow(scraper).to receive(:parse_html_document) do
          Nokogiri::HTML(BerghainHtmlHelper.duplicate_events)
        end

        errors = scraper.scrape(web_source)

        expect(errors.count).to eq(1)
        expect(errors.first[:message]).to eq('Error in creating event. Details - Validation failed: Url has already been taken')
        expect(errors.first[:websource]).to eq('http://berghain.de/events/')
      end
    end
  end
end
