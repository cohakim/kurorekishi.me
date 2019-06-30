class Internal::OrdersController < ApplicationController
  def show
    @order = Order.find(params[:id])
    render json: @order, serializer: OrderSerializer
  end
end
