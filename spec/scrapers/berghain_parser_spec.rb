# frozen_string_literal: true

require 'rails_helper'

describe BerghainParser do
  describe '#scrape' do
    context 'Berghain page has events with relevant dates' do
      let(:web_source) { create(:web_source, url: 'http://berghain.com/events', scraper: 'BerghainScraper') }

      it 'scrapes events information and creates new events' do
        scraper = BerghainParser.new

        allow(scraper).to receive(:parse_html_document) { Nokogiri::HTML(BerghainHtmlHelper.event_with_dates_content) }

        expect { scraper.scrape(web_source) }.to change(Event, :count).by(2)
      end
    end
  end
end
