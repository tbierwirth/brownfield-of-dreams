require "rails_helper"

RSpec.describe InviteMailer, type: :mailer do
  let(:email){ Capybara::Node::Simple.new(email.body.to_s)}

  it "Sends activation link" do
    github_user = File.open('./spec/fixtures/user.json')
    stub_request(:get, "https://api.github.com/users/tbierwirth").
      to_return(status: 200, body: github_user)

    current_user = File.open('./spec/fixtures/current_user.json')
    stub_request(:get, "https://api.github.com/user").
      to_return(status: 200, body: current_user)

    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    service = GithubService.new(ENV['GITHUB_API_KEY'])
    sender = service.get_current_user
    recipient = service.get_user('tbierwirth')[:login]
    recipient_email = service.get_user('tbierwirth')[:email]

    email = InviteMailer.invite(sender, recipient, recipient_email)

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal ['no-reply@sleepy-woodland-37224.herokuapp.com'], email.from
    assert_equal [recipient_email], email.to
    assert_equal 'Brownfield of Dreams Invite', email.subject
    expect(email).to have_content("sleepy-woodland-37224.herokuapp.com/register")
  end
end
