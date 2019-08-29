require 'rails_helper'

describe 'visitor visits video show page' do
  it 'clicks on the bookmark page and is showed a flash message telling them to log in' do
    tutorial = create(:tutorial)
    create(:video, tutorial_id: tutorial.id)

    visit tutorial_path(tutorial)

    expect(page).to have_link("Please login")
    click_on 'Please login'
    expect(current_path).to eq(login_path)

    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit tutorial_path(tutorial)

    click_on 'Bookmark'

    expect(current_path).to eq(tutorial_path(tutorial))
    expect(page).to_not have_content("Please login")
  end
end
