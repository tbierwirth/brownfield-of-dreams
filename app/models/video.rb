class Video < ApplicationRecord
  has_many :user_videos
  has_many :users, through: :user_videos
  belongs_to :tutorial

  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :video_id
  validates_presence_of :thumbnail
  validates_presence_of :tutorial_id
  validates_presence_of :position
end
