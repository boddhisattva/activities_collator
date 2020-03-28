class Event < ApplicationRecord
  belongs_to :web_source

  validates :title, :start, :finish, :url, presence: true
  validates :url, uniqueness: true
end
