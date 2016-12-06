class GitHubService
  attr_reader :user

  def initialize(user)
    @user = user
    @connection = Faraday.new("https://api.github.com/users/")
  end

  def get_repos
    response = @connection.get "#{user.username}/repos"
    parse(response.body).map do |repo|
      Repo.new(repo)
    end
  end

  private

  def parse(response)
    JSON.parse(response, symbolize_names: true)
  end

end
