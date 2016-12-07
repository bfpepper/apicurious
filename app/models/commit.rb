class Commit
  attr_reader :message, :created

  def initialize(commit)
    @message = commit[:commit][:message]
    @created = commit[:commit][:author][:date]
  end

end
