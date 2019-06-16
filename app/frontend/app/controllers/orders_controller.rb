class OrdersController < ApplicationController
  before_action :verify_active_order_exists, only: :new
  before_action :verify_active_order_not_exists, only: :show
  before_action :verify_closing_order_exists, only: :result

  def show
    @order = find_order.decorate
  end

  def result
    @order = find_order.decorate
  end

  def new
    @form = OrderForm.new(order_params)
  end

  def create
    @form = OrderForm.new(order_params)

    if @form.valid?
      @form.save!

      redirect_to order_path
    else
      render :new
    end
  end

  def abort
    order = find_order
    order.abort!
    redirect_to order_path
  end

  def confirm
    order = find_order
    order.confirm! if order.may_confirm?
    redirect_to result_order_path
  end

  def close
    order = find_order
    order.close!
    redirect_to getstarted_path
  end

  def progressbar
    order = find_order.decorate
    render file: 'orders/components/_progressbar', locals: { order: order }, layout: false
  end

  def status_dialog
    order = find_order.decorate
    render file: 'orders/components/_status_dialog', locals: { order: order }, layout: false
  end

  private

  def find_order
    Order.user(current_user).active.first
  end

  def verify_active_order_exists
    redirect_to order_path if find_order.present?
  end

  def verify_active_order_not_exists
    redirect_to new_order_path unless find_order.present?
  end

  def verify_closing_order_exists
    redirect_to order_path unless find_order.closing?
  end

  def order_params
    params.permit(
      :collect_method, :archive_url,
      :start_message, :finish_message,
      :protect_reply, :protect_favorite, :collect_from, :collect_to,
    ).merge(user_id: current_user.id)
  end
end
