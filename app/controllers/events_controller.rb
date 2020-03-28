# frozen_string_literal: true

class EventsController < ApplicationController
  ITEMS_PER_PAGE = 10
  DEFAULT_PAGE_NUMBER = 1

  def index
    @events = if event_params.present?
                Event.joins(:web_source)
                     .select('title, events.url, start, finish, web_source_id, web_sources.name AS web_source_name, web_sources.url AS web_source_url')
                     .search_by(event_params)
              else
                Event.joins(:web_source)
                     .select('title, events.url, start, finish, web_source_id, web_sources.name AS web_source_name, web_sources.url AS web_source_url')
              end.paginate(page: params[:page] || DEFAULT_PAGE_NUMBER, per_page: ITEMS_PER_PAGE)

    @web_sources = WebSource.where('id IN (?)', distinct_web_source_ids)
  end

  private

  def event_params
    params.fetch(:events, {}).permit(:title, :start, :finish, :web_source_id)
  end

  def distinct_web_source_ids
    @events.map(&:web_source_id).uniq
  end
end
