class Event < ApplicationRecord
  include Filterable

  belongs_to :web_source

  validates :title, :start, :finish, :url, presence: true
  validates :url, uniqueness: true

  scope :filter_by_title, ->(title) { where('lower(title) LIKE lower(?)', title) }
  scope :filter_by_start, ->(start) { where('start >= ?', start) }
  scope :filter_by_finish, ->(finish) { where('finish <= ?', finish) }
  scope :filter_by_web_source_id, ->(web_source_id) { where(web_source_id: web_source_id) }
end
