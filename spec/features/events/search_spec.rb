# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Events search', type: :feature do
  context 'User is on the app home page' do
    scenario 'user searches for events without specifying any filter criteria' do
      events = create_list(:event, 5)

      visit root_path

      click_button 'Search'

      expect(page).to have_text('Random event title')
    end
  end
end
