class SessionsController < ApplicationController
  def create
    @response =
      Faraday.post("https://github.com/login/oauth/access_token?client_id=#{ENV["git_hub_client_id"]}&client_secret=#{ENV["git_hub_client_secret"]}&code=#{params["code"]}")

      token = @response.body.split(/\W+/)[1]

      oauth_response = Faraday.get("https://api.github.com/user?access_token=#{token}")
      auth = JSON.parse(oauth_response.body)

      user          = User.find_or_create_by(uid: auth["id"])
      user.username = auth["login"]
      user.uid      = auth["id"]
      user.name     = auth["name"]
      user.avatar   = auth["avatar_url"]
      user.bio      = auth["bio"]
      user.location = auth["location"]
      user.joined   = auth["created_at"]
      user.token    = token
      user.save

      session[:user_id] = user.id
      redirect_to dashboard_index_path
  end
end
