class Admin::CompaniesController < Admin::ResourcesController

  def index
    respond_to do |format|
      format.html { super }
      format.json do
        @companies = Company.order(:name)
        render json: @companies.where("name like ?", "%#{params[:q]}%")
                               .as_json( only: [:id, :name] )
      end
    end
  end

end
