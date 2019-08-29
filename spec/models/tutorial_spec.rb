require 'rails_helper'

RSpec.describe Tutorial, type: :model do
  describe  "relationships" do
      it {should have_many(:videos) }
  end

  it "dependent destroy" do
    tutorial_1 = create(:tutorial, classroom: true)
    create(:video, tutorial: tutorial_1)

    expect { tutorial_1.destroy }.to change { Video.count }.by(-1)
  end

  describe  "validations" do
    it { should validate_presence_of(:title)}
    it { should validate_presence_of(:description)}
    it { should validate_presence_of(:thumbnail)}
  end
end
