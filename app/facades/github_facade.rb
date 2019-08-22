class GithubFacade
  def repositories
    service = GithubService.new
    service.repositories[0,5].map do |repo|
      GithubRepo.new(repo)
    end
  end

  def followers
    service = GithubService.new
    service.followers.map do |follower|
      GithubFollower.new(follower)
    end
  end
end
