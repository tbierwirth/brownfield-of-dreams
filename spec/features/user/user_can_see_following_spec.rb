require 'rails_helper'

RSpec.describe 'User' do
  it "can see their follwing in their github section on their dashboard" do
    VCR.use_cassette('github following') do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(page).to have_content('Github')
      expect(page).to have_content('Following')
      expect(page).to have_css('.following', count: 3)

      within(first('.following')) do
        expect(page).to have_css('.login:not(:empty)')
      end
    end
  end
end
