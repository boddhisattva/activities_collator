class NotExecutedError < StandardError; end

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

    def parse_events(_webpage_document)
      raise NotExecutedError, 'The parse_events method needs to be implemented in a subclass of BaseParser'
    end

    def parse_dates(_event_element)
      raise NotExecutedError, 'The parse_dates method needs to be implemented in a subclass of BaseParser'
    end

    def parse_title(_event_element)
      raise NotExecutedError, 'The parse_title method needs to be implemented in a subclass of BaseParser'
    end

    def parse_description(_event_element)
      raise NotExecutedError, 'The parse_description method needs to be implemented in a subclass of BaseParser'
    end

    def parse_url(_base_url, _event_element)
      raise NotExecutedError, 'The parse_url method needs to be implemented in a subclass of BaseParser'
    end
end
