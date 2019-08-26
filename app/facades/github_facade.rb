class GithubFacade
  def initialize(token)
    @token = token
  end

  def repositories
    service = GithubService.new(@token)
    service.repositories[0,5].map do |repo|
      GithubRepo.new(repo)
    end
  end

  def followers
    service = GithubService.new(@token)
    service.followers.map do |follower|
      GithubFollower.new(follower)
    end
  end

  def following
    service = GithubService.new(@token)
    service.following.map do |follower|
      GithubFollowing.new(follower)
    end
  end
end
