# frozen_string_literal: true

class DateValidator
  include ActiveModel::Validations

  attr_accessor :start_date, :finish_date

  validate :start_date_before_finish_date, if: :start_date_and_finish_date_present?

  def start_date_and_finish_date_present?
    start_date.present? && finish_date.present?
  end

  def start_date_before_finish_date
    if start_date > finish_date
      errors.add(:start_date, 'cannot be greater than finish date')
    end
  end
end
