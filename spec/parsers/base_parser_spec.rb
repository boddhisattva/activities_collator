# frozen_string_literal: true

require 'rails_helper'

describe BaseParser do
  class BrandNewParser < BaseParser; end

  describe '#extract_all_events_info' do
    context 'page specific parser method(e.g., parse_events) is not defined in the subclass' do
      it 'raises a NotExecutedError with an appropriate error message' do
        webpage_document = Nokogiri::HTML(ParserWithoutParsingMethodsHtmlHelper.events_content)

        brand_new_parser = BrandNewParser.new

        expect { brand_new_parser.extract_all_events_info('https://brandnew.org/en/calender', webpage_document) }
          .to raise_error(NotExecutedError, 'The parse_events method needs to be implemented in a subclass of BaseParser')
      end
    end
  end
end
