module API
  class SearchController < BaseController
    def index
      render json: { results: SearchAllSourcesCommand.new(params).perform }
    end
  end
end
