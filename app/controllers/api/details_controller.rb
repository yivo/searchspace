module API
  class DetailsController < BaseController
    def show
      # TODO Check for existing source
      render json: "#{params[:source]}_details_loader".camelize.constantize.new.load(params[:url])
    end
  end
end
