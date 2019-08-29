class GithubService
  def initialize(token)
    @token = token
  end

  def repositories
    get_json('/user/repos')
  end

  def followers
    get_json('/user/followers')
  end

  def following
    get_json('/user/following')
  end

  def get_current_user
    get_json('/user')[:login]
  end

  def get_user(handle)
    get_json("/users/#{handle}")
  end

  private
  def conn
    Faraday.new(url: 'https://api.github.com/') do |f|
      f.headers['Authorization'] = @token
      f.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    response = conn.get(url)
    JSON.parse(response.body, symbolize_names: true)
  end

end
