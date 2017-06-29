module API
  class DetailsController < BaseController

    before_action :find_source

    def show
      render json: "#{@source.name}_result_details_loader".camelize.constantize.new.load(params[:url])
    end

  protected
    def find_source
      @source = Search.find_source_by_name(params[:source]) || not_found
    end
  end
end
