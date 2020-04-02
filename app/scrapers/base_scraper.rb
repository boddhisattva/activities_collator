# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

class BaseScraper
  def initialize(parser)
    @errors = []
    @parser = parser
  end

  def scrape(web_source)
    unless parser.class.const_defined?(:EVENT_URL) # CB if this has to be moved to the base parser class
      raise NotImplementedError, 'An event URL needs to be present in a subclass'
    end

    webpage_document = parse_html_document(parser.class::EVENT_URL)

    parser.extract_all_events_info(web_source.url, webpage_document).each do |event|
      create_event(web_source, event)
    end

    errors
  end

  attr_reader :parser

  private

  attr_reader :errors

  def parse_events(_webpage_document)
    raise NotImplementedError, 'The events method needs to be implemented in a subclass of BaseScraper'
  end

  def create_event(web_source, event)
    # start_date, end_date = extract_dates(event)

    web_source.events.create!(
      title: event[:title],
      start: event[:start],
      finish: event[:finish],
      description: event[:description],
      url: event[:url]
    )
  rescue StandardError => e
    errors << {
      websource: parser.class::EVENT_URL,
      message: "Error in creating event. Details - #{e.message}"
    }
  end

  def parse_dates(_event)
    raise NotImplementedError, 'The extract_dates method needs to be implemented in a subclass of BaseScraper'
  end

  def parse_html_document(url)
    Nokogiri::HTML(open(url))
  end

  def parse_title(_event)
    raise NotImplementedError, 'The title method needs to be implemented in a subclass of BaseScraper'
  end

  def parse_description(_event)
    raise NotImplementedError, 'The description method needs to be implemented in a subclass of BaseScraper'
  end

  def parse_url(_base_url, _event)
    raise NotImplementedError, 'The url method needs to be implemented in a subclass of BaseScraper'
  end
end
