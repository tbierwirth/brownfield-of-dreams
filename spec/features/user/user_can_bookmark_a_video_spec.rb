require 'rails_helper'

describe 'A registered user' do
  before :each do
    @tutorial= create(:tutorial, title: "How to Tie Your Shoes")
    @video = create(:video, title: "The Bunny Ears Technique", tutorial: @tutorial)
    user = create(:user)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
  end
  it 'can add videos to their bookmarks' do
    visit tutorial_path(@tutorial)

    expect {
      click_on 'Bookmark'
    }.to change { UserVideo.count }.by(1)

    expect(page).to have_content("Bookmark added to your dashboard")
  end

  it "can't add the same bookmark more than once" do
    visit tutorial_path(@tutorial)

    click_on 'Bookmark'
    expect(page).to have_content("Bookmark added to your dashboard")
    click_on 'Bookmark'
    expect(page).to have_content("Already in your bookmarks")
  end

  it "can see their bookmarks" do
    visit tutorial_path(@tutorial)

    click_on 'Bookmark'

    visit dashboard_path

    within "#tutorial-#{@tutorial.id}" do
      expect(page).to have_content(@tutorial.title)
      expect(page).to have_content(@video.title)
    end
  end
end
