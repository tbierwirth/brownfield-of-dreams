require 'rails_helper'

RSpec.describe 'User' do
  it "can see their followers in their github section on their dashboard" do
    VCR.use_cassette('github followers') do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(page).to have_content('Github')
      expect(page).to have_content('Followers')
      expect(page).to have_css('.follower', count: 2)

      within(first('.follower')) do
        expect(page).to have_css('.login:not(:empty)')
      end
    end
  end
end
