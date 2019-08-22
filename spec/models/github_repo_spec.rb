require 'rails_helper'

describe GithubRepo do
  it "exists" do
    attributes = {
      name: 'Battleship',
      html_url: "https://github.com/tbierwirth/battleship"
    }

    repo = GithubRepo.new(attributes)
    expect(repo).to be_a(GithubRepo)
    expect(repo.name).to eq('Battleship')
    expect(repo.html_url).to eq('https://github.com/tbierwirth/battleship')
  end
end
