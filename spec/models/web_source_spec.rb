# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WebSource, type: :model do
  describe 'associations' do
    it { should have_many(:events).dependent(:destroy) }
  end

  describe 'validations' do
    subject { build(:web_source) }

    it { should validate_uniqueness_of(:url) }
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:name) }
  end
end
