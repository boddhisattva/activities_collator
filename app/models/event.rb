# frozen_string_literal: true

class Event < ApplicationRecord
  belongs_to :web_source

  validates :title, :start, :finish, :url, presence: true
  validates :url, uniqueness: true

  scope :filter_by_title, ->(title) { where('title ILIKE ?', "%#{title}%") }
  scope :filter_by_start, ->(start) { where('start >= ?', start) }
  scope :filter_by_finish, ->(finish) { where('finish <= ?', finish) }
  scope :filter_by_web_source_id, ->(web_source_id) { where(web_source_id: web_source_id) }

  def self.search_by(filtering_params)
    results = where(nil)
    filtering_params.each do |key, value|
      results = results.public_send("filter_by_#{key}", value) if value.present?
    end
    results
  end
end
