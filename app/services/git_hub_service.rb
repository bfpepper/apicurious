class GitHubService
  attr_reader :user

  def initialize(user)
    @user = user
    @connection = Faraday.new("https://api.github.com/") do |faraday|
      faraday.adapter Faraday.default_adapter
      faraday.headers["Authorization"] = "token #{user.token}"
    end
  end

  def get_repos
    response = @connection.get "users/#{user.username}/repos"
    parse(response.body).map do |repo|
      Repo.new(repo)
    end
  end

  def get_orgs
    response = @connection.get("users/#{user.username}/orgs")
    parse(response.body).map do |org|
      Org.new(org)
    end
  end

  def get_commits
    get_repo_commits(get_repos).flatten
  end

  private

  def get_repo_commits(all_repos)
    all_repos.map do |repo|
      repo_response = @connection.get("/repos/#{user.username}/#{repo.name}/commits?author=#{user.username}").body
      set_commit_message(repo_response)
    end
  end

  def set_commit_message(repo_response)
    parse(repo_response).map do |commit|
      Commit.new(commit)
    end
  end

  def parse(response)
    JSON.parse(response, symbolize_names: true)
  end

end
