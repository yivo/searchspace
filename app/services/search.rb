module Search
  class << self
    extend Memoist

    def sources
      Rails.application.eager_load!
      Search::Source.descendants.map(&:new).sort_by(&:name)
    end
    memoize :sources
  end
end
