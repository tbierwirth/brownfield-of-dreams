class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos
  has_many :user_tokens
  has_many :friendships
  has_many :friends, through: :friendships

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

  def add_token(provider, token, uid)
    user_tokens.create!(provider: provider, token: "token #{token}", uid: uid)
  end

  def github_authorized?
    user_tokens.where(provider: "github").present?
  end

  def github_token
    user_tokens.select(:token).where(provider: "github").pluck(:token).join
  end
end
