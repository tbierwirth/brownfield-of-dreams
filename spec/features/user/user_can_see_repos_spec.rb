require 'rails_helper'

RSpec.describe 'User' do
  it "can see their repositories in their github section on their dashboard" do
    VCR.use_cassette('github repo') do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      expect(page).to have_content('Github')
      expect(page).to have_css('.repo', count: 5)

      within(first('.repo')) do
        expect(page).to have_css('.name:not(:empty)')
        expect(page).to have_link('.name')
      end
    end
  end
end
