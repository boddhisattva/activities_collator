# frozen_string_literal: true

class WebSource < ApplicationRecord
  has_many :events, dependent: :destroy

  validates :name, :url, presence: true
  validates :url, uniqueness: true
end
