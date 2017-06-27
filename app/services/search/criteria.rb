class Search::Criteria
  def initialize(phrase)
    @phrase = phrase.to_s.squish
  end

  def applicable?
    @phrase.present?
  end

  def to_hash
    method_not_implemented
  end

  def to_query
    to_hash.to_query
  end
end
