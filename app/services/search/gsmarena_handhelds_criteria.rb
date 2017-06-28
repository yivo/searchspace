class Search::GSMArenaHandheldsCriteria < Search::Criteria
  def to_hash
    { sName: @phrase }
  end
end
