class ShoutSearchQuery
  def initialize(term:)
    @term = term
  end

  def to_relation
    Shout.where(id: search_result_ids)
  end

  private

    attr_reader :term

    def search_result_ids
      Shout.search { fulltext term }.hits.map(&:primary_key)
    end
end
