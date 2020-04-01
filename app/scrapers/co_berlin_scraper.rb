# frozen_string_literal: true

class CoBerlinScraper < BaseScraper
  EVENT_URL = 'https://www.co-berlin.org/en/calender'

  private

  def events(webpage_document)
    webpage_document.css('.seite-c-single')
  end

  def extract_dates(event)
    if date_range?(event)
      start_date = event.css('.date-display-start')[0]['content']
      end_date   = event.css('.date-display-end')[0]['content']
    else
      start_date = event.css('.date-display-single')[0]['content']
      end_date   = event.css('.date-display-single')[0]['content']
    end

    [start_date.to_date, end_date.to_date]
  end

  def date_range?(event)
    !event.css('.date-display-range').empty?
  end

  def title(event)
    event.css('.article-title').text
  end

  def description(event)
    event.css('.article-text').text
  end

  def url(base_url, event)
    "#{base_url}#{event.css('a').first.attributes['href'].value}"
  end
end
