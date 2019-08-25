class BookmarkFacade
  def initialize(user)
    @user = user
  end
  def tutorials
    @user.get_bookmarks
  end
end
