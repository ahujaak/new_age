module ApiExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: { errors: e.message }, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: { errors: e.message }, status: :unprocessable_entity
    end

    rescue_from ActionController::UnpermittedParameters do |exception|
      render json: { errors:  { unknown_parameters: exception.params } }, status: :bad_request
    end

    rescue_from(ActionController::ParameterMissing) do |parameter_missing_exception|
      error = {}
      error[parameter_missing_exception.param] = ['parameter is required']
      render json: { errors: error }, status: :unprocessable_entity
    end

    rescue_from ArgumentError do |e|
      render json: { errors: e.message }, status: :bad_request
    end
  end
end
