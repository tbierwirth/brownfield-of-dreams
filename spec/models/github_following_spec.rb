require "rails_helper"

RSpec.describe GithubFollowing do
  it "exists" do
    attributes = {
      login: "tbierwirth",
      html_url: "http://www.github.com/tbierwirth"
    }

    following = GithubFollowing.new(attributes)

    expect(following).to be_a GithubFollowing
    expect(following.login).to eq("tbierwirth")
    expect(following.html_url).to eq("http://www.github.com/tbierwirth")
  end
end
