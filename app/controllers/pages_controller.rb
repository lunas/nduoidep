class PagesController < ApplicationController

  expose(:current_issue) { Issue.where(id: params[:issue_id]).first || Issue.latest.first }
  expose(:company_id)    { (params[:company_id] =~ /^\d+$/).nil? ? nil : params[:company_id] }

  # GET /issues/1/pages?company_id=2
  def index
    company_pages = company_id.present? ? current_issue.pages_for_company(company_id) : []
    render json: {pages: company_pages}
  end

  # GET /issues/1/pages/1
  def show
    @page = current_issue.pages.where(page_nr: params[:id]).first

    image_url = @page.present? ? @page.url : "eoi"
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: {image: image_url.to_s} }
    end
  end

  # GET /pages/new
  # GET /pages/new.json
  def new
    @page = Page.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page }
    end
  end

  # GET /pages/1/edit
  def edit
    @page = Page.find(params[:id])
  end

  # POST /pages
  # POST /pages.json
  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        format.html { redirect_to @page, notice: 'Page was successfully created.' }
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /pages/1
  # PUT /pages/1.json
  def update
    @page = Page.find(params[:id])

    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pages/1
  # DELETE /pages/1.json
  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to pages_url }
      format.json { head :no_content }
    end
  end
end
