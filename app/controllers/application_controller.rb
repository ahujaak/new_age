class ApplicationController < ActionController::API
  include ApiExceptionHandler

  def current_driver
    Driver.find(params[:driver_id])
  end
end
