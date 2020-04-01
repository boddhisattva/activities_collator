# frozen_string_literal: true

require 'rails_helper'

describe BerghainScraper do
  describe '#scrape' do
    context 'Berghain page has events with relevant dates' do
      let(:web_source) { WebSource.create(name: 'test', url: 'http://berghain.com/events', scraper: 'BerghainScraper') }

      it 'scrapes events information and creates new events' do
        scraper = BerghainScraper.new

        allow(scraper).to receive(:parse_html_document) { Nokogiri::HTML(BerghainHtmlHelper.event_with_dates_content) }

        expect { scraper.scrape(web_source) }.to change(Event, :count).by(2)
      end
    end
  end
end
