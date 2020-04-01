# frozen_string_literal: true

require 'rails_helper'

describe BaseScraper do
  class BrandNewScraper < BaseScraper; end

  class ScraperWithoutParserMethods < BaseScraper
    EVENT_URL = 'https://www.co-berlin.org/en/calender'
  end

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
  end
end
