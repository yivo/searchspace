class SearchAllSourcesCommand
  def initialize(params)
    @params = params
  end

  def perform
    Search.sources.each_with_object [] do |source, memo|
      criteria = source.create_criteria { |k| k.new(@params[:phrase]) }.tap(&:validate!)
      memo.concat Search::Performer.new.perform(source, criteria)
    end
  end
end
