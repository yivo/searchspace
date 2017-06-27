class Search::Criteria
  def initialize(phrase)
    @phrase = phrase.to_s.squish
  end

  def validate!
    if @phrase.length < phrase_minimum_length
      raise Search::CriteriaError, "phrase is too short (minimum #{phrase_minimum_length} characters required)"
    end

    if @phrase.length > phrase_maximum_length
      raise Search::CriteriaError, "phrase is too long (maximum #{phrase_maximum_length} characters)"
    end
    true
  end

  def to_hash
    method_not_implemented
  end

  def to_query
    to_hash.to_query
  end

  def phrase_minimum_length
    2
  end

  def phrase_maximum_length
    100
  end
end
