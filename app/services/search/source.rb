class Search::Source

  # Used to track all available sources in application.
  extend ActiveSupport::DescendantsTracker

  # Use this to identity source.
  #   Search::GitHubRepositoriesSource.new.name => :github_repositories
  #   Search::EbayDronesSource.new.name         => :ebay_drones
  #   Search::Source.new.name                   => nil
  #
  # See also: config/initializers/inflections.rb
  def name
    self.class.name.gsub(/(?:\ASearch::)|(?:Source\z)/, '').underscore.to_sym if self.class < Search::Source
  end

  def search_url
    method_not_implemented
  end
end
