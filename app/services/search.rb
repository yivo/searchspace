module Search
  class << self
    extend Memoist

    def sources
      Rails.application.eager_load!
      Search::Source.descendants.map(&:new).sort_by(&:name)
    end
    memoize :sources

    def find_source_by_name(name)
      name = name.to_sym unless Symbol === name
      sources.find { |source| source.name == name }
    end
  end
end
