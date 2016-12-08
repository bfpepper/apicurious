require 'rails_helper'

describe GitHubService do
  user = User.create(username: "bfpepper", token: "#{ENV['guthub_user_token']}")
  context "#repos" do
      it "returns all repos for a user" do
        VCR.use_cassette("repos") do
        repos = GitHubService.new(user).get_repos
        repo = repos.first

        expect(repos).to be_an(Array)
        expect(repo.name).to eq(repos.first.name)
        expect(repo.url).to eq(repos.first.url)
      end
    end
    context "#get_orgs" do
      it "gets all ogs for a given user" do
        VCR.use_cassette("orgs") do
          orgs = GitHubService.new(user).get_orgs
          org = orgs.first

          expect(org).to be_nil
        end
      end
    end
    context "#get_commits" do
      it "returns all commits for a given user" do
        VCR.use_cassette("commits") do
          commits = GitHubService.new(user).get_commits
          commit = commits.first

          expect(commits).to be_an(Array)
          expect(commit.message).to eq("Added Ben's AR method")
          expect(commit.created).to eq("2016-08-31T13:33:15Z")
        end
      end
    end
  end
end
