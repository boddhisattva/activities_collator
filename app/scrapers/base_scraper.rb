# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

class BaseScraper
  def initialize
    @errors = []
  end

  def scrape(web_source)
    unless self.class.const_defined?(:EVENT_URL)
      raise NotImplementedError, 'An event URL needs to be present in a subclass'
    end

    webpage_document = parse_html_document(self.class::EVENT_URL)

    events(webpage_document).each do |event|
      create_event(web_source, event)
    end

    errors
  end

  private

  attr_reader :errors

  def events
    raise NotImplementedError, 'This needs to be implemented in a subclass of BaseScraper'
  end

  def create_event(web_source, event)
    start_date, end_date = extract_dates(event)

    web_source.events.create!(
      title: title(event),
      start: start_date,
      finish: end_date,
      description: description(event),
      url: url(web_source.url, event)
    )
  rescue StandardError => e
    errors << {
      websource: self.class::EVENT_URL,
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