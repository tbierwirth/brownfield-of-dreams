class UserVideo < ApplicationRecord
  belongs_to :video, foreign_key: "video_id"
  belongs_to :user, foreign_key: "user_id"

  validates_numericality_of :user_id
  validates_numericality_of :video_id
end
