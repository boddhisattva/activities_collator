# frozen_string_literal: true

class BerghainScraper < BaseScraper
  private

  def events(webpage_document)
    webpage_document.css('.upcoming-event')
  end

  def extract_dates(event)
    if dates_exist?(event)
      start_date = DateTime.parse(event.css('p').first.text)
      end_date = DateTime.parse(event.css('p').first.text)
    end

    [start_date, end_date]
  end

  def dates_exist?(event)
    event.css('p').first.text.present?
  end

  def title(event)
    event.css('h2').text.strip
  end

  def description(event)
    event.css('h3').text + '\n' + event.css('h4').text
  end

  def url(event)
    "#{web_source.url}#{event.attributes['href'].value}"
  end
end
