class reposController < ApplicationController
  def index
    @repos = DashboardService.new(current_user).get_repos
  end

  private

  def get_response
    response = Faraday.get("https://api.github.com/user?access_token=#{current_user.token}")
    @auth = JSON.parse(response.body)
  end
end
