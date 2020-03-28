module EventsHelper
  def format_date(date)
    date.strftime('%e %b %Y, %I:%M %P')
  end
end
