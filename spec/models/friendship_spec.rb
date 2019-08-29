require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'relationships' do
    it { should belong_to(:user)}
    it { should belong_to(:friend)}
  end

  describe 'validations' do
    it { should validate_presence_of(:user_id)}
    it { should validate_presence_of(:friend_id)}
  end

  it "create friendship" do
    user_1 = create(:user)
    user_2 = create(:user)

    user_1.friendships.create(friend_id: user_2.id)

    expect(user_1.friends).to eq([user_2])
    expect(user_2.friends).to eq([user_1])
  end

end
