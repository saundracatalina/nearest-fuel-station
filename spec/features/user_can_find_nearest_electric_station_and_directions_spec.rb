require 'rails_helper'

describe 'search results for closest electric station to Turing' do
  it 'can see the closest electric fuel station with its info' do
    visit '/'

    select 'Turing', from: :location
    click_button 'Find Nearest Station'

    expect(current_path).to eq(search_path)

    expect(page).to have_css('.station', count: 1)
    expect(page).to have_css('.name', count: 1)
    expect(page).to have_css('.address', count: 1)
    expect(page).to have_css('.fuel_type', count: 1)
    expect(page).to have_css('.access_times', count: 1)
  end

  it 'can see the distance to that station and turn-by-turn directions'
end

# As a user
# When I visit "/"
# And I select "Turing" form the start location drop down (Note: Use the existing search form)
# And I click "Find Nearest Station"
# Then I should be on page "/search"
# Then I should see the closest electric fuel station to me.
# For that station I should see
# - Name
# - Address
# - Fuel Type
# - Access Times
# I should also see:
# - the distance of the nearest station (should be 0.1 miles)
# - the travel time from Turing to that fuel station (should be 1 min)
# - The direction instructions to get to that fuel station
#   "Turn left onto Lawrence St Destination will be on the left"
