class OrdersController < ApplicationController

  # GET /:driver_id/orders
  def index
    orders = current_driver.orders
    render json: { data: orders }, status: :ok
  end

  # POST /:driver_id/orders
  def create
    order = current_driver.orders.new(permitted_params)
    order.status = "completed"
    if order.save
      render json: { data: order }, status: :ok
    else
      render json: { errors: order.errors }, status: :unprocessable_entity
    end
  end

  private

  def permitted_params
    params.require(:order).permit(
      :fuel_quantity, :price, :comment, :payment_method_id
    )
  end
end
