# frozen_string_literal: true

module EventsHelper
  def format_date(date)
    date.strftime('%e %b, %Y')
  end
end
