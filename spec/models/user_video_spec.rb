require 'rails_helper'

RSpec.describe UserVideo, type: :model do
  describe 'relationships' do
    it { should belong_to(:video)}
    it { should belong_to(:user)}
  end

  describe 'validations' do
    it { should validate_numericality_of(:user_id)}
    it { should validate_numericality_of(:video_id)}
  end
end
