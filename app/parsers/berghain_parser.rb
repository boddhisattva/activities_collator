# frozen_string_literal: true

class BerghainParser < BaseParser
  EVENT_URL = 'http://berghain.de/events/'

  private

  def parse_events(webpage_document)
    webpage_document.css('.upcoming-event')
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
