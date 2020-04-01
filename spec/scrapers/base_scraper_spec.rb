# frozen_string_literal: true

require 'rails_helper'

describe BaseScraper do
  class BrandNewScraper < BaseScraper; end

  describe '#scrape' do
    let(:web_source) { create(:web_source) }
    let(:new_scraper) { BrandNewScraper.new }

    context 'event URL not defined in the subclass' do
      it 'raises a NotImplementedError without an appropriate error message' do
        expect { new_scraper.scrape(web_source) }.to raise_error(NotImplementedError, 'An event URL needs to be present in a subclass')
      end
    end
  end
end
