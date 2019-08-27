require "rails_helper"

RSpec.describe Video, type: :model do
  describe 'relationships' do
    it { should have_many(:user_videos)}
    it { should have_many(:users).through(:user_videos)}
    it { should belong_to(:tutorial)}
  end

  it "dependent destroy" do
    user_1 = create(:user)
    tutorial_1 = create(:tutorial, classroom: true)
    video_1 = create(:video, tutorial: tutorial_1)
    create(:user_video, video: video_1, user: user_1)

    expect{ video_1.destroy }.to change{ UserVideo.count }.by(-1)
  end

  describe 'validations' do
    it { should validate_presence_of(:title)}
    it { should validate_presence_of(:description)}
    it { should validate_presence_of(:video_id)}
    it { should validate_presence_of(:tutorial_id)}
    it { should validate_presence_of(:position)}
  end
end
