# frozen_string_literal: true

require 'rails_helper'

describe BerghainScraper do
  describe '#scrape' do
    context 'Berghain page related event with start and end dates' do
      let(:web_source) { WebSource.create(name: 'test', url: 'http://berghain.com/events', scraper: 'BerghainScraper') }

      it 'scrapes events information and creates new events' do
        scraper = BerghainScraper.new(web_source)

        allow(scraper).to receive(:parse_html_document) { Nokogiri::HTML(event_with_dates_content) }

        expect { scraper.scrape }.to change(Event, :count).by(1)
      end
    end
  end
end

def event_with_dates_content
  <<-PAGE_CONTENT
    <a href="/en/event/68453/" class="upcoming-event block p-3/4 md:p-1 pb-2 bg-light-black hover:bg-light-black-flash bg-clip-padding border-b-2 border-transparent">
      <p class="text-sm md:text-md leading-tight">
          Thursday
          <span class="font-bold">
          26.03.2020
          </span>
          start 22:00
      </p>
      <h2
          class="text-lg md:text-xl font-bold text-white"
          style="color: #B2EDAF"
          >
          Kisloty
      </h2>
      <h3
          class="text-sm md:text-md text-white"
          style="color: #B2EDAF"
          >
          Säule
      </h3>
      <h4 class="text-lg md:text-xl ml-3/4 leading-tight">
          <span class="font-bold">
          <span class="xs:whitespace-no-wrap">Rune Bagge</span>,
          </span>
          <span class="font-bold">
          <span class="xs:whitespace-no-wrap">Sasha Tsereteli</span>,
          </span>
          <span class="font-bold">
          <span class="xs:whitespace-no-wrap">Sergei German</span>,
          </span>
          <span class="font-bold">
          <span class="xs:whitespace-no-wrap">Textasy</span>
          </span>
      </h4>
    </a>
  PAGE_CONTENT
end
