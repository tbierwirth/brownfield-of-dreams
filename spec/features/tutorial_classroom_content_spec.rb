require "rails_helper"

RSpec.describe "Tutorial Show Page" do
  before :each do
    @user = create(:user)

    @tutorial_1 = create(:tutorial, title: "How to Make Cheese", classroom: true)
    @tutorial_2 = create(:tutorial, title: "How to Yo-Yo", classroom: false)

    @video_1 = create(:video, tutorial: @tutorial_1)
    @video_2 = create(:video, tutorial: @tutorial_2)
  end
  it "Shows videos marked with classroom content to only logged in users" do
    visit root_path
    click_on @tutorial_1.title
    expect(page).to_not have_content(@video_1.title)
    expect(page).to have_content("The page you were looking for doesn't exist.")

    visit root_path
    click_on @tutorial_2.title
    expect(page).to have_content(@video_2.title)
  end

  it "A logged in user can view all tutorials" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    visit root_path
    click_on @tutorial_1.title
    expect(page).to have_content(@video_1.title)

    visit root_path
    click_on @tutorial_2.title
    expect(page).to have_content(@video_2.title)
  end
end
