class Repo

  def initialize(repo)
    @name = repo[:name]
    @url = repo[:html_url]
  end

end
