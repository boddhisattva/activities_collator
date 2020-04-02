class BaseParser

  def extract_all_events_info(base_url, webpage_document)
    parse_events(webpage_document).each_with_object([]) do |event_element, page_events_info|
      page_events_info << parse_event_data(base_url, event_element)
    end
  end

  private

    def parse_event_data(base_url, event_element)
      start_date, finish_date = parse_dates(event_element)

      {
        title: parse_title(event_element),
        description: parse_description(event_element),
        start: start_date,
        finish: finish_date,
        url: parse_url(base_url, event_element)
      }
    end
end
