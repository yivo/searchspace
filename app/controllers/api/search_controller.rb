module API
  class SearchController < BaseController
    rescue_from Search::CriteriaError, with: :handle_invalid_user_supplied_parameters

    def index
      render json: { results: SearchAllSourcesCommand.new(params).perform }
    end

  protected
    def handle_invalid_user_supplied_parameters(exception)
      head :unprocessable_entity
    end
  end
end
