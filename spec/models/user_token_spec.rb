require 'rails_helper'

RSpec.describe UserToken, type: :model do
  describe "relationships" do
    it { should belong_to(:user) }
  end

  it "exists" do
    attributes = {
      provider: "github",
      token: "1234",
      uid: "12345"
    }
  user_1 =  create(:user)
  user_token = user_1.user_tokens.create(attributes)

  expect(user_token).to be_a UserToken
  end

  describe "validations" do
    it { should validate_presence_of(:provider)}
    it { should validate_presence_of(:token)}
    it { should validate_presence_of(:uid)}
  end
end
