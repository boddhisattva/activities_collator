class BaseParser

  private

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
end
