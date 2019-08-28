require "rails_helper"

RSpec.describe "An admin user can add a tutorial" do
  before :each do
    @admin = create(:user, role: 1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

  end

  it "enters required information" do
    visit new_admin_tutorial_path

    fill_in 'Title', with: 'How to Walk in High Heels'
    fill_in 'Description', with: 'A step-by-step guide to mastering the art of walking in heels'
    fill_in 'Thumbnail', with: 'https://i.ytimg.com/vi/qMkRHW9zE1c/hqdefault.jpg'

    click_on 'Save'

    tutorial_1 = Tutorial.last
    expect(current_path).to eq(tutorial_path(tutorial_1))
    expect(page).to have_content("Successfully created tutorial.")
  end

  it "doesn't enter in all required information" do
    visit new_admin_tutorial_path

    fill_in 'Title', with: nil
    fill_in 'Description', with: nil
    fill_in 'Thumbnail', with: nil

    click_on 'Save'

    expect(page).to have_content("Couldn't create tutorial.")
  end
end
