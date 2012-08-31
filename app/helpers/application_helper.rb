module ApplicationHelper
  def api_template(params)
    if params.nil? || params[:api_version].nil?
      return "api_latest"
    end

    return "api_v#{params[:api_version]}"
  end
end
