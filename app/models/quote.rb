class Quote
  def initialize(details)
    @comment = details.fetch(:comment)
    @by      = details.fetch(:by)
  end

  attr_reader :comment, :by
end
