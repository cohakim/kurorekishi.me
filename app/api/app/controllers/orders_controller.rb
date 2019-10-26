class OrdersController < ApplicationController
  before_action :authenticate!

  def create
    render json: { id: 123, user_id: 456, collect_count: 789 }, status: :created
  end

  def show
    render json: { id: 123, user_id: 111, collect_count: 777 }, status: :ok
  end
end
