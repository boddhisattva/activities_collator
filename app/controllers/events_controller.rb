# frozen_string_literal: true

class EventsController < ApplicationController
  ITEMS_PER_PAGE = 10
  DEFAULT_PAGE_NUMBER = 1

  def index
    @events = if event_params.present? && dates_are_valid?
                Event.joins(:web_source)
                     .select('title, events.url, start, finish, web_source_id, web_sources.name AS web_source_name, web_sources.url AS web_source_url')
                     .search_by(event_params)
              else
                Event.joins(:web_source)
                     .select('title, events.url, start, finish, web_source_id, web_sources.name AS web_source_name, web_sources.url AS web_source_url')
              end.paginate(page: params[:page] || DEFAULT_PAGE_NUMBER, per_page: ITEMS_PER_PAGE)

    @web_sources = WebSource.all.select('id, name')
  end

  private

  def event_params
    params.fetch(:events, {}).permit(:title, :start, :finish, :web_source_id)
  end

  def dates_are_valid?
    @date_validator = DateValidator.new
    start_date = event_params[:start]
    finish_date = event_params[:finish]
    if start_date.present?
      @date_validator.start_date = Date.strptime(start_date, '%m/%d/%Y')
    end
    if finish_date.present?
      @date_validator.finish_date = Date.strptime(finish_date, '%m/%d/%Y')
    end
    @date_validator.valid?
  end
end
