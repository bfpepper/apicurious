require "rails_helper"

describe "user login with oauth" do
  it "user logs in with github oauth" do
    visit root_path

    click_on("Login With GitHub")

    fill_in("Username or email address"), with: "bfpepper87"
    fill_in("password"), with: "#{ENV['me']}"

    expect(page).to have("Ben Pepper")
  end
end
