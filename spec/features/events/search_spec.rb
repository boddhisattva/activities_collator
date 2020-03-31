# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Events search', type: :feature do
  context 'User is on the app home page' do
    scenario 'user searches for events without specifying any search filter criteria' do
      events = create_list(:event, 5)

      visit root_path

      click_button 'Search'

      expect(page).to have_text('Random event title')
    end

    context 'user searches for events with specific search filter criteria' do
      scenario 'event start date is before event finish date' do
        event_in_near_future = create :event, title: 'Near future event', start: 2.weeks.from_now, finish: 3.weeks.from_now
        event_for_much_later = create :event, title: 'Later Event', start: 2.months.from_now, finish: 3.months.from_now

        visit root_path

        within('.filters') do
          fill_in 'events[start]', with: 1.week.from_now.strftime('%m/%d/%Y')
          fill_in 'events[finish]', with: 1.month.from_now.strftime('%m/%d/%Y')
        end

        click_button 'Search'

        expect(page).to have_text('Near future event')
        expect(page).not_to have_text('Later event')
      end

      scenario 'event start date is greater event finish date' do
        event_in_near_future = create :event, title: 'Near future event', start: 2.weeks.from_now, finish: 3.weeks.from_now

        visit root_path

        within('.filters') do
          fill_in 'events[start]', with: 1.month.from_now.strftime('%m/%d/%Y')
          fill_in 'events[finish]', with: 2.weeks.from_now.strftime('%m/%d/%Y')
        end

        click_button 'Search'

        expect(page).to have_text('Start date cannot be greater than finish date')
        expect(page).to have_css('.alert-danger')
      end

      scenario 'user searches with multiple search filter criteria' do
        websource = create :web_source, name: 'new websource'
        another_websource = create :web_source, new: 'another websource'
        event_in_near_future = create :event, title: 'Near future event', start: 2.weeks.from_now, finish: 3.weeks.from_now, web_source: websource
        event_for_much_later = create :event, title: 'Later Event', start: 2.months.from_now, finish: 3.months.from_now, web_source: another_websource

        visit root_path

        within('.filters') do
          fill_in 'events[title]', with: 'near future'
          fill_in 'events[start]', with: 1.week.from_now.strftime('%m/%d/%Y')
          fill_in 'events[finish]', with: 2.months.from_now.strftime('%m/%d/%Y')
          select('new websource', from: 'events[web_source_id]')
        end

        click_button 'Search'

        expect(page).to have_text('Near future event')
        expect(page).not_to have_text('later event')
      end
    end
  end
end
