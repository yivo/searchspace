module Search
  class << self
    extend Memoist

    def sources
      Rails.application.eager_load!
      Search::Source.descendants.map(&:new)
    end
    memoize :sources
  end
end
