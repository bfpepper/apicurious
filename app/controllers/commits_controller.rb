class CommitsController < ApplicationController

  def index
    @commits = GitHubService.new(current_user).get_commits
  end

end
