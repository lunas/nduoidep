class Api::PagesController < Api::BaseController

  expose(:page) { Page.find(params[:id]) }

  expose(:new_page) {
    # We get back a string from the client when posting an page because
    # of the way the request is constructed; so parse it into JSON and
    # put it back into the params hash:
    if params[:page].is_a? String
      params[:page] = ActiveSupport::JSON.decode(params[:page])
    end

    Issue.find(params[:page][:issue_id]).pages.build(params[:page])
  }

  expose(:url) { params[:url] }

  def create
    accept_only_json do
      if new_page.save
        send_json_data({ page_id: new_page.id }, 200)
      else
        send_error_messages new_page
      end
    end
  end

  def update
    accept_only_json do
      page.update_attribute(:url, url )
      send_ok
    end
  end

end