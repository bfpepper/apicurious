require 'rails_helper'

describe GitHubService do
  context "#repos" do
    it "returns all repos for a user" do
      user = User.new
      user.token = ENV['github_user_token']
      repos = GitHubService.new(user).get_repos
      repo = repos.first

      expect(repos).to be_an(Array)
      expect(repo).to have_key(:name)
    end
  end
end
