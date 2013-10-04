class BoardMember
  def initialize(details)
    @name        = details.fetch(:name)
    @position    = details.fetch(:position)
    @facebook    = details.fetch(:facebook)    { nil }
    @twitter     = details.fetch(:twitter)     { nil }
    @google_plus = details.fetch(:google_plus) { nil }
  end

  attr_reader :name, :position, :facebook, :twitter, :google_plus
end
