class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, :class_name => 'User'

  validates_presence_of :user_id
  validates_presence_of :friend_id

  after_create :create_inverse, unless: :inverse_exists?

  def create_inverse
    self.class.create(inverse_friendship)
  end

  def inverse_friendship
    {user_id: self.friend_id, friend_id: self.user_id}
  end

  def inverse_exists?
    self.class.exists?(inverse_friendship)
  end
end
