class OrgsController < ApplicationController

  def index
    @orgs = GitHubService.new(current_user).get_orgs
  end

end
