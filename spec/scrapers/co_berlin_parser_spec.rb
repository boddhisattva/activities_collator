# frozen_string_literal: true

require 'rails_helper'

describe CoBerlinScraper do
  describe '#scrape' do
    let!(:web_source) { WebSource.create(name: 'test', url: 'http://coberlin.com/events', scraper: 'CoBerlinScraper') }

    context 'Co Berlin page has unique events on its page' do
      context 'events have start and end dates' do
        it 'scrapes events information and creates new events' do
          scraper = CoBerlinScraper.new

          allow(scraper).to receive(:parse_html_document) do
            Nokogiri::HTML(CoBerlinHtmlHelper.events_with_start_and_end_date_content)
          end

          expect { scraper.scrape(web_source) }.to change(Event, :count).by(2)
        end

        context 'duplicate event information is present on page' do
          it 'does not create multiple events' do
          end
        end
      end

      context 'event only has start dates' do
        it 'scrapes events information and creates new events' do
          scraper = CoBerlinScraper.new

          allow(scraper).to receive(:parse_html_document) do
            Nokogiri::HTML(CoBerlinHtmlHelper.event_with_start_date_content)
          end

          expect { scraper.scrape(web_source) }.to change(Event, :count).by(1)
        end
      end
    end
  end
end