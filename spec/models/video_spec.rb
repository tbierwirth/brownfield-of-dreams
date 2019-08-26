require "rails_helper"

RSpec.describe Video, type: :model do
  describe 'relationships' do
    it { should have_many(:user_videos)}
    it { should have_many(:users).through(:user_videos)}
    it { should belong_to(:tutorial)}
  end

  describe 'validations' do
    it { should validate_presence_of(:title)}
    it { should validate_presence_of(:description)}
    it { should validate_presence_of(:video_id)}
    it { should validate_presence_of(:thumbnail)}
    it { should validate_presence_of(:tutorial_id)}
    it { should validate_presence_of(:position)}
  end
end
