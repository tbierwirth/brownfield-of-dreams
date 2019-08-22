require "rails_helper"

RSpec.describe GithubFollower do
  it "exists" do
    attributes = {
      login: "tbierwirth",
      html_url: "http://www.github.com/tbierwirth"
    }

    follower = GithubFollower.new(attributes)

    expect(follower).to be_a GithubFollower
    expect(follower.login).to eq("tbierwirth")
    expect(follower.html_url).to eq("http://www.github.com/tbierwirth")
  end
end
