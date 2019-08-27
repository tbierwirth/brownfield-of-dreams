require "rails_helper"

RSpec.describe AccountActivationMailer, type: :mailer do
  let(:email){ Capybara::Node::Simple.new(email.body.to_s)}

  it "Sends activation link" do
    user = create(:user)
    email = AccountActivationMailer.activate(user)

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['no-reply@sleepy-woodland-37224.herokuapp.com'], email.from
    assert_equal [user.email], email.to
    assert_equal 'Account Activation', email.subject
  end
end
