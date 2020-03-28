# frozen_string_literal: true

module Filterable
  extend ActiveSupport::Concern

  module ClassMethods
    def search_by(filtering_params)
      results = where(nil)
      filtering_params.each do |key, value|
        if value.present?
          results = results.public_send("filter_by_#{key}", value)
        end
      end
      results
    end
  end
end
