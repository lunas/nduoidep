class Api::BaseController < ActionController::Base

  respond_to :json

  # Wraps the block passed to the method into a begin/rescue call so all errors are caught, and makes sure only json
  # requests are served (others get status 400 'bad request').
  #
  # @example wrap a block in +accept_only_json
  #   accept_only_json do
  #     render_for_api api_template(params), :json => User.all
  #   end
  # @param [&block] block to execute (e.g. render command, see example)
  # @return [json] returns value of passed block or renders a json error response.
  #   If an error occurs (e.g. the template constructed based on the parameter +api_version+ is not found)
  #   a status 400 response ('bad request') is returned.
  #   If a non-json request is made, a status 415 is returned.
  def accept_only_json
    respond_to do |format|
      format.json do
        begin
          yield
        rescue ActiveRecord::RecordNotFound => e
          render json: { :error => "Resource not found"}, status: 404
        rescue ActiveRecord::RecordInvalid => e
          render json: { :error => e.to_s || "Invalid attributes"}, status: 409
        rescue Exception => e
          render json: { :error => e.to_s }, status: 400
        end
      end
      format.any { render params[:format].to_sym => { :error => 'Api accepts only json'}, :status => 415 }
    end
  end

  def send_ok(message = 'ok')
    send_json_data message, 200
  end

  def send_error_messages(model, status = 500)
    send_json_data({ :error => collect_error_messages_for(model) }, status)
  end

  def send_json_data(message, status)
    data = if message.is_a? Hash
             message
           else
             {:message => message}
           end

    render json: data, :status => status
  end

  private

  def collect_error_messages_for(model)
    model.errors.full_messages.uniq[0...Rails.application.config.errors_to_show].join("\n")
  end

end