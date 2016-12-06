class ReposController < ApplicationController
  def index
    @repos = GitHubService.new(current_user).get_repos
  end
end
