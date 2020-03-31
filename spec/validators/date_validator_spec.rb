# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DateValidator do
  before do
    @date_validator = DateValidator.new
    @date_validator.start_date = Time.zone.tomorrow
    @date_validator.finish_date = Time.zone.today
  end
  subject { @date_validator }

  describe 'when start date is greater than finish date' do
    it { should_not be_valid }
  end
end
