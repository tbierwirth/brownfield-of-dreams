require 'rails_helper'

RSpec.describe 'User' do
  before :each do
    followers = File.open('./spec/fixtures/followers.json')
    stub_request(:get, "https://api.github.com/user/followers").
      to_return(status: 200, body: followers)

    following = File.open('./spec/fixtures/following.json')
    stub_request(:get, "https://api.github.com/user/following").
      to_return(status: 200, body: following)

    repos = File.open('./spec/fixtures/repos.json')
    stub_request(:get, "https://api.github.com/user/repos").
      to_return(status: 200, body: repos)
  end
  it "can see their followers in their github section on their dashboard" do
    mock_omniauth

    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit dashboard_path

    click_on 'Connect to Github'

    expect(page).to have_content('Github')
    expect(page).to have_content('Followers')
    expect(page).to have_css('.follower', count: 4)

    within(first('.follower')) do
      expect(page).to have_css('.login:not(:empty)')
    end
  end
end
