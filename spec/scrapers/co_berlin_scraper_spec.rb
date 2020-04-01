# frozen_string_literal: true

require 'rails_helper'

describe CoBerlinScraper do
  describe '#scrape' do
    let!(:web_source) { WebSource.create(name: 'test', url: 'http://coberlin.com/events', scraper: 'CoBerlinScraper') }
    let(:scraper) { CoBerlinScraper.new }

    context 'Co Berlin page has unique events on its page' do
      context 'events have start and end dates' do
        it 'scrapes events information and creates new events' do
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
        it 'scrapes event information and creates new event' do
          allow(scraper).to receive(:parse_html_document) do
            Nokogiri::HTML(CoBerlinHtmlHelper.event_with_start_date_content)
          end

          expect { scraper.scrape(web_source) }.to change(Event, :count).by(1)
        end
      end

      context 'page contains duplicate event entries' do
        it 'does not create duplicate events in the database' do
          allow(scraper).to receive(:parse_html_document) do
            Nokogiri::HTML(CoBerlinHtmlHelper.duplicate_events)
          end

          expect { scraper.scrape(web_source) }.to change(Event, :count).by(1)
        end

        it 'captures errors when trying to create duplicate events' do
          allow(scraper).to receive(:parse_html_document) do
            Nokogiri::HTML(CoBerlinHtmlHelper.duplicate_events)
          end

          errors = scraper.scrape(web_source)

          expect(errors.count).to eq(1)
          expect(errors.first[:message]).to eq('Error in creating event. Details - Validation failed: Url has already been taken')
          expect(errors.first[:websource]).to eq('https://www.co-berlin.org/en/calender')
        end
      end
    end
  end
end
