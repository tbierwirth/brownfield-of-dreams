require "rails_helper"

RSpec.describe "As a registered user" do
  describe "I can visit the send invite page" do
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

      github_user = File.open('./spec/fixtures/user.json')
      stub_request(:get, "https://api.github.com/users/tbierwirth").
        to_return(status: 200, body: github_user)

      current_user = File.open('./spec/fixtures/current_user.json')
      stub_request(:get, "https://api.github.com/user").
        to_return(status: 200, body: current_user)

      not_found = File.open('./spec/fixtures/not_found.json')
      stub_request(:get, "https://api.github.com/users/ji3o4jios").
        to_return(status: 404, body: not_found)
    end
    it "I can send an invite to a user with a valid Github Handle" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      click_on 'Send an Invite'
      expect(current_path).to eq(invite_path)

      fill_in 'Github Handle', with: 'tbierwirth'
      click_on 'Send Invite'

      expect(current_path).to eq(dashboard_path)
      expect(page).to have_content('Invite sent!')
    end
    it "I can not send an invite to a user with an invalid Github Handle" do
      user = create(:user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      click_on 'Send an Invite'
      expect(current_path).to eq(invite_path)

      fill_in 'Github Handle', with: 'ji3o4jios'
      click_on 'Send Invite'

      expect(current_path).to eq(invite_path)
      expect(page).to have_content("User does not exist or does not have a public email")
    end
  end
end
