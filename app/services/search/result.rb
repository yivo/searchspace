class Search::Result
  def initialize(name, source, details = {})
    @name    = name
    @source  = source
    @details = details
  end

  attr_reader :name, :source, :details

  def to_hash
    instance_values.symbolize_keys.merge(source: source.name)
  end
end
