class GithubFollower
  attr_reader :login, :html_url, :uid

  def initialize(attributes = {})
    @login = attributes[:login]
    @html_url = attributes[:html_url]
    @uid = attributes[:id].to_s
  end

  def registered?
    UserToken.where(uid: self.uid).present?
  end

  def user_id
    UserToken.select(:user_id).where(uid: self.uid).pluck(:user_id).join
  end

  def friended?(current_user_id)
    Friendship.where(user_id: current_user_id, friend_id: user_id).present?
  end
end
