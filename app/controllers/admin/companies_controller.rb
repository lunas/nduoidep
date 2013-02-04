class Admin::CompaniesController < Admin::ResourcesController

  def xxxindex
    @companies = Company.order(:name)
    respond_to do |format|
      format.html
      format.json { render json: @companies.where("name like ?", "%#{params[:q]}%") }
    end
  end

end
