require 'rails_helper'

RSpec.describe 'User Show Page' do
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

    @tyler = create(:user)
    @tay = create(:user)
    @tyler.user_tokens.create(provider: 'github', token: 'ji342n4o2', uid: '46985326')
    @tay.user_tokens.create(provider: 'github', token: 'aknkl424', uid: '47490116')
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@tyler)
  end
  it "a user sees an add friend button next to a registered follower" do

    visit dashboard_path

    expect(page).to have_content('Friends')

    within '.friends' do
      expect(page).to have_content('No friends added')
    end

    within(first('.follower')) do
      expect(page).to_not have_button('Add as Friend')
    end

    within '.followers' do
      expect(page).to have_button('Add as Friend')
      click_on 'Add as Friend'
    end

    expect(current_path).to eq(dashboard_path)

    within '.followers' do
      expect(page).to_not have_button('Add as Friend')
    end

    within '.friends' do
      expect(page).to have_css('.friend', count: 1)
    end
  end

  it "verifies inverse friendship" do
    visit dashboard_path

    within ".followers" do
      click_on "Add as Friend"
    end
    binding.pry
  end
end
