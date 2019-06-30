class OrdersController < ApplicationController
  before_action :welcome_crawler, only: :show
  before_action :require_logged_in
  before_action :require_active_order_is_non_existent, only: :new
  before_action :require_active_order_is_existent, only: [:show, :progressbar, :status_dialog]
  before_action :require_closing_order_is_existent, only: :result

  def new
    @form = OrderForm.new(order_params)
  end

  def show
    @order = find_order.decorate
    @server_status = ServerStatusDecorator.decorate(
      ServerStatus.current_server_status
    )
  end

  def result
    @order = find_order.decorate
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
    order.abort! if order.may_abort?
    redirect_to order_path
  end

  def confirm
    order = find_order
    order.confirm! if order.may_confirm?
    redirect_to result_order_path
  end

  def close
    order = find_order
    order.close! if order.may_close?
    redirect_to getstarted_path
  end

  def progressbar
    @order = find_order.decorate
    render 'progressbar', layout: false
  end

  def status_dialog
    @order = find_order.decorate
    @server_status = ServerStatusDecorator.decorate(
      ServerStatus.current_server_status
    )
    render 'status_dialog', layout: false
  end

  private

  def find_order
    Order.user(current_user).active.first
  end

  def order_params
    params.permit(
      :collect_method, :archive_url,
      :start_message, :finish_message,
      :protect_reply, :protect_favorite, :collect_from, :collect_to,
    ).merge(user_id: current_user.id)
  end

  def welcome_crawler
    return if current_user.present?
    render 'roots/show'
  end

  def require_logged_in
    return if logged_in?
    redirect_to root_path
  end

  def require_active_order_is_non_existent
    return if find_order.blank?
    redirect_to order_path
  end

  def require_active_order_is_existent
    return if find_order.present?
    redirect_to new_order_path
  end

  def require_closing_order_is_existent
    return if find_order.closing?
    redirect_to order_path
  end
end
