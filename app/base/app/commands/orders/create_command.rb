class Orders::CreateCommand < Patterns::Command
  attr_reader :user, :order

  def initialize(user:, order:)
    @user  = user
    @order = order
  end

  def call
    order.user = user
    order.save!
  end
end
