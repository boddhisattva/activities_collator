# frozen_string_literal: true

class EventsController < ApplicationController
  ITEMS_PER_PAGE = 10

  def index
    @events = Event.paginate(page: params[:page] || 1, per_page: ITEMS_PER_PAGE).includes(:web_source)
  end
end
