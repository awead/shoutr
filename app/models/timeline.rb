class Timeline
  include ActiveModel::Conversion

  def initialize(users, scope = Shout)
    @users = users
    @scope = scope
  end

  def shouts
    scope
      .where(user_id: users)
      .order(created_at: :desc)
  end

  private

    attr_reader :users, :scope
end
