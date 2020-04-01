# frozen_string_literal: true

class CoBerlinParser # < BaseScraper
  EVENT_URL = 'https://www.co-berlin.org/en/calender'

  # private

  def parse_events(base_url, webpage_document)
    events = webpage_document.css('.seite-c-single')
    events.each_with_object([]) do |event_element, page_events|
      page_events << parse_event_data(base_url, event_element)
    end
  end

  def parse_event_data(base_url, event_element) # this can go to a base class parser method
    start_date, finish_date = parse_dates(event_element)

    {
      title: parse_title(event_element),
      description: parse_description(event_element),
      start: start_date,
      finish: finish_date,
      url: parse_url(base_url, event_element)
    }
  end

  def parse_dates(event_element)
    if date_range?(event_element)
      start_date = event_element.css('.date-display-start')[0]['content']
      end_date   = event_element.css('.date-display-end')[0]['content']
    else
      start_date = event_element.css('.date-display-single')[0]['content']
      end_date   = event_element.css('.date-display-single')[0]['content']
    end

    [start_date.to_date, end_date.to_date]
  end

  def date_range?(event_element)
    !event_element.css('.date-display-range').empty?
  end

  def parse_title(event_element)
    event_element.css('.article-title').text
  end

  def parse_description(event_element)
    event_element.css('.article-text').text
  end

  def parse_url(base_url, event_element)
    "#{base_url}#{event_element.css('a').first.attributes['href'].value}"
  end
end
