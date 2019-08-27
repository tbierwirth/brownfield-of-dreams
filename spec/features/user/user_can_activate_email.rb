require "rails_helper"

RSpec.describe "As a guest user" do
  describe "When I fill in all of the required information to register and click on register" do
    it "I should see a message on my dashboard indicating that I need to activate my account" do
      user = create(:user)

      visit '/'

      click_on "Sign In"

      expect(current_path).to eq(login_path)

      fill_in 'session[email]', with: user.email
      fill_in 'session[password]', with: user.password

      click_on 'Log In'

      expect(page).to have_content("This account has not yet been activated. Please check your email.")

      visit activation_path(:code => user.activation_code)

      expect(current_path).to eq(activated_path)
      expect(page).to have_content("Thank you! Your account is now activated.")

      visit dashboard_path
      user.reload.activated
      expect(page).to have_content("Status: Active")
    end


  end
end
