class OrderAdjustmentsController < ApplicationController
  # before_action :authenticate_request
  # also authorize the create request for admin users only

  before_action :find_order

  # GET /:driver_id/orders/:order_id/order_adjustments
  def index
    render json: { data: @order.order_adjustments }, status: :ok
  end

  # POST /:driver_id/orders/:order_id/order_adjustments
  def create
    order_adjustment = @order.order_adjustments.new(permitted_params.merge!(driver_id: params[:driver_id]))
    if order_adjustment.save
      render json: { data: order_adjustment }, status: :ok
    else
      render json: { errors: order_adjustment.errors }, status: :unprocessable_entity
    end
  end

  private

  def permitted_params
    params.require(:order_adjustment).permit(
      :adjustment_type, :amount, :description
    )
  end

  def find_order
    @order = current_driver.orders.find(params[:order_id])
  end
end
