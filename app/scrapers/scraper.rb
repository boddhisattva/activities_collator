# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

class Scraper
  def initialize(parser)
    @parser = parser
    @errors = []
  end

  def scrape(web_source, url_to_scrape)
    webpage_document = get_page_data(url_to_scrape)

    parser.extract_all_events_info(web_source.url, webpage_document).each do |event|
      create_event(web_source, event, url_to_scrape)
    end

    errors
  end

  attr_reader :parser

  private

  attr_reader :errors

  def create_event(web_source, event, url_to_scrape)
    web_source.events.create!(
      title: event[:title],
      start: event[:start],
      finish: event[:finish],
      description: event[:description],
      url: event[:url]
    )
  rescue => e
    errors << {
      websource: url_to_scrape,
      message: "Error in creating event. Details - #{e.message}"
    }
  end

  def get_page_data(url)
    Nokogiri::HTML(open(url))
  end
end
