class Search::GSMArenaHandheldsCriteria < Search::Criteria
  def to_hash
    { sName: @phrase, sQuickSearch: 'yes' }
  end
end
