require 'rails_helper'

RSpec.describe 'User' do
  it "can click a button to connect their Github account" do
    VCR.use_cassette('github auth') do
      user = create(:user)
      mock_omniauth
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      click_on 'Connect to Github'

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_no_button('Connect to Github')
      expect(page).to have_content('Github')
    end
  end
end
