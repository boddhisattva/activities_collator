# frozen_string_literal: true

class CoBerlinParser < BaseScraper
  EVENT_URL = 'https://www.co-berlin.org/en/calender'

  private

  def events(webpage_document)
    webpage_document.css('.seite-c-single')
  end

  def extract_dates(event_element)
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

  def title(event_element)
    event_element.css('.article-title').text
  end

  def description(event_element)
    event_element.css('.article-text').text
  end

  def url(base_url, event_element)
    "#{base_url}#{event_element.css('a').first.attributes['href'].value}"
  end
end
