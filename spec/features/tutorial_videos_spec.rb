require "rails_helper"

RSpec.describe "Tutorial Show Page" do
  it "A tutorial with no videos won't error out and instead display a message" do
    tutorial_1 = create(:tutorial)

    visit root_path
    click_on tutorial_1.title
    expect(page).to have_content("This tutorial doesn't have any videos!")

    video_1 = create(:video, tutorial: tutorial_1)

    visit root_path
    click_on tutorial_1.title
    expect(page).to have_content(video_1.title)
  end
end
