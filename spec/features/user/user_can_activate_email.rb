require "rails_helper"

RSpec.describe "As a guest user" do
  describe "When I register an account" do
    it "I should be able to activate my account with my activation code" do
      user = create(:user)
      expect(user.activated).to eq(false)
      visit '/'

      click_on "Sign In"

      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'

      expect(page).to have_content("This account has not yet been activated. Please check your email.")

      visit activation_path(:code => user.activation_code)

      user.reload.activated
      expect(user.activated).to eq(true)

      expect(current_path).to eq(activated_path)
      expect(page).to have_content("Thank you! Your account is now activated.")

      visit dashboard_path
      expect(page).to have_content("Status: Active")
    end

    it "I can not activate my account with an invalid code" do
      user = create(:user)
      expect(user.activated).to eq(false)
      visit '/'

      click_on "Sign In"

      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'

      expect(page).to have_content("This account has not yet been activated. Please check your email.")

      visit activation_path(:code => 'tniotn23t2')

      user.reload.activated
      expect(user.activated).to eq(false)

      expect(current_path).to eq(root_path)
      expect(page).to have_content("Code is invalid")
    end

  end
end
