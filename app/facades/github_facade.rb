class GithubFacade
  def repositories
    service = GithubService.new
    service.repositories[0,5].map do |repo|
      GithubRepo.new(repo)
    end
  end
end
