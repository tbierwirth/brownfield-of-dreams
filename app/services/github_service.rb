class GithubService

  def repositories
    get_json('/user/repos')
  end

  private
  def conn
    Faraday.new(url: 'https://api.github.com/') do |f|
      f.headers['Authorization'] = ENV['GITHUB_API_KEY']
      f.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

end
