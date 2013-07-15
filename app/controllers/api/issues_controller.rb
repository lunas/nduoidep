class Api::IssuesController < Api::BaseController

  expose(:new_issue) {
    # We get back a string from the client when posting an issue because
    # of the way the request is constructed; so parse it into JSON and
    # put it back into the params hash:
    if params[:issue].is_a? String
      params[:issue] = ActiveSupport::JSON.decode(params[:issue])
    end

    Issue.new(params[:issue])
  }

  def create
    accept_only_json do
      if new_issue.save
        send_json_data({ issue_id: new_issue.id }, 200)
      else
        send_error_messages new_issue
      end
    end
  end

end