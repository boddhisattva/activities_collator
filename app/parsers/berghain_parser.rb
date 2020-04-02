# frozen_string_literal: true

class BerghainParser < BaseParser
  EVENT_URL = 'http://berghain.de/events/'

  # private

  def parse_events(base_url, webpage_document)
    events = webpage_document.css('.upcoming-event')
    events.each_with_object([]) do |event_element, page_events|
      page_events << parse_event_data(base_url, event_element)
    end
  end

  def parse_dates(event_element)
    if dates_exist?(event_element)
      start_date = event_element.css('p').first.text.to_date
      end_date = event_element.css('p').first.text.to_date
    end

    [start_date, end_date]
  end

  def dates_exist?(event_element)
    event_element.css('p').first.text.present?
  end

  def parse_title(event_element)
    event_element.css('h2').text.strip
  end

  def parse_description(event_element)
    event_element.css('h3').text + '\n' + event_element.css('h4').text
  end

  def parse_url(base_url, event_element)
    "#{base_url}#{event_element.attributes['href'].value}"
  end
end
