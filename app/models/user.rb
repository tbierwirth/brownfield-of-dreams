class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :password
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def get_bookmarks
    Tutorial.includes(videos: :user_videos)
            .where(user_videos: { user_id: self.id })
            .order('user_videos.created_at')
  end
end
