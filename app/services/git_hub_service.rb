class GitHubService
  attr_reader :user

  def initialize(user)
    @user = user
    @connection = Faraday.new("https://api.github.com/users/") do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.headers["Authorization"] = "token #{user.token}"
    end
  end

  def get_repos
    response = @connection.get "#{user.username}/repos"
    parse(response.body).map do |repo|
      Repo.new(repo)
    end
  end

  def get_orgs
    response = @connection.get('user/orgs')
    parse(response.body).map do |org|
      Org.new(org)
    end
  end

  private

  def parse(response)
    JSON.parse(response, symbolize_names: true)
  end

end
