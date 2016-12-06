class Org

  def initialize(org)
    @name = org[:login]
    @repos = org[:repos_url]
    @pic = org[:avatar_url]
    @description = org[:description]
  end

end
