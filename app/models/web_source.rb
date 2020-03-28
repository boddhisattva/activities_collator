class WebSource < ApplicationRecord
  has_many :events, dependent: :destroy

  validates :name, :url, :scraper, presence: true
  validates :url, uniqueness: true
end
