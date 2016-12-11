require "rails_helper"

describe "user can see all repos" do
  it "user sees all repos when loged in" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    VCR.use_cassette("repos") do
      visit repos_path

      expect(page).to have_content("active-record-exploration")
    end
  end
  it "user can see all commits" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    VCR.use_cassette("commits") do
      visit commits_path

      expect(page).to have_content("Merge pull request #4 from bfpepper/services_test add commits to index page.")
    end
  end

  it "user can see landing page" do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit dashboard_index_path

    expect(page).to have_content(@user.name)
  end
end
