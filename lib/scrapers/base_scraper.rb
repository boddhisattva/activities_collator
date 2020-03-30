# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

class BaseScraper
  ACTIVITY_TYPE = {
    events: 'event'
  }.freeze

  def initialize(web_source)
    @web_source = web_source
    @errors = []
    @items_scraped_count = Hash.new(0)
  end

  def scrape
    raise NotImplementedError, 'An event URL needs to be present in a subclass' unless self.class.const_defined?(:EVENT_URL)

    webpage_document = parse_html_document(self.class::EVENT_URL)

    events(webpage_document).each do |event|
      create_event(event)
    end

    [items_scraped_count, errors]
  end

  private

  attr_reader :web_source, :items_scraped_count, :errors

  def events
    raise NotImplementedError, 'This needs to be implemented in a subclass of BaseScraper'
  end

  def create_event(event)
    start_date, end_date = extract_dates(event)

    web_source.events.create!(
      title: title(event),
      start: start_date,
      finish: end_date,
      description: description(event),
      url: url(event)
    )

    items_scraped_count[ACTIVITY_TYPE[:events]] += 1
  rescue StandardError => e
    errors << {
      websource: web_source.url, type: ACTIVITY_TYPE[:events],
      message: "Error in creating event. Details - #{e.message}"
    }
  end

  def extract_dates
    raise NotImplementedError, 'This needs to be implemented in a subclass of BaseScraper'
  end

  def parse_html_document(url)
    Nokogiri::HTML(open(url))
  end

  def title(_event)
    raise NotImplementedError, 'This needs to be implemented in a subclass of BaseScraper'
  end

  def description(_event)
    raise NotImplementedError, 'This needs to be implemented in a subclass of BaseScraper'
  end

  def url(_event)
    raise NotImplementedError, 'This needs to be implemented in a subclass of BaseScraper'
  end
end
