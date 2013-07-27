require 'rest_client'
require 'page_uploader'

class Uploader
  # Uploads images in image-dir to aws, interacting with ny-nguoidep.com
  # to create the according issue and pages on the server.

  # Create an issue (API)
  # Use returned issue_id:
  # for each image in image-dir,
  #   Create a page with issue_id and page nr extracted from image file name (API)
  #   use returned page_id to
  #   upload image to aws
  #   use returned url to update page on the server
  # that's it.

  IMAGE_DIR = './pages'
  IMAGE_PATTERN = '*.jpg'
  BASE_ADDRESS = 'http://www.nguoidepmagazine-ny.com/api'

  attr_reader :images

  def initialize(dir = IMAGE_DIR, image_pattern = IMAGE_PATTERN, base_addr = BASE_ADDRESS)
    @image_dir = dir
    @image_pattern = image_pattern
    @base_addr = base_addr
    @images = read_image_dir
    @errors = []
    @page_uploader = PageUploader.new
  end

  def read_image_dir
    Dir.chdir(@image_dir)
    Dir[@image_pattern].map{ |f| File.expand_path(f) }
  end

  def run
    begin
      issue_id = create_issue
      @images.each do |image|
        create_and_upload_page(image)
      end
    rescue => e
      @errors << e.message
    ensure
      display_errors
    end
  end

  def create_and_upload_page(image)
    begin
      page_id = create_page(issue_id, image)
      url = upload(page_id, image)
      update_page(url)
    rescue => e
      @erros << e.message
    end
  end

  def create_issue
    title, date = get_issue_data
    response = post( 'issues', {issue: {title: title, date: date}} )
    iid = json_response(response.body)['issue_id']
    if iid.nil?
      raise StandardError, "Didn't get valid issue_id from server. Sent title #{title} and date #{date}."
    end
    iid
  end

  def create_page(issue_id, image)
    page_nr, title = parse_name(image)
    response = post( 'pages', {page:{issue_id: issue_id, page_nr: page_nr, title: title}})
    pid = json_response(response.body)['page_id']
    if pid.nil?
      raise StandardError, "Didn't get valid issue_id from server. Sent issue_id #{issue_id}, title #{title} and page_nr #{page_nr}."
    end
    pid
  end

  def parse_name(image)
    nr = image[0..2].to_i
    raise StandardError, "Couldn't find page nr in image file name: #{image}" unless nr > 0
    title = image[3..-1].gsub(/_Done/i, '')
    [nr, title]
  end

  def upload(page_id, image)
    url = upload_to_aws(page_id, image)
    update_page(page_id, url)
  end

  # Uploads image to aws and returns url.
  def upload_to_aws(page_id, image)
    page_uploader.page_id = page_id
    file = File.open(image)
    page_uploader.store!(file)
    page_uploader.url
  end

  def update_page(page_id, url)
    post( "pages/#{page_id}", {url: url}, :put )
  end

  def post(path, params, method = :post)
    RestClient.send(method, get_url(path),
    #RestClient.post(get_url(path),
                            params.to_json,
                            content_type: :json,
                            accept: :json)
  end

  def get_url(path)
    "#{@base_addr}/#{path}"
  end

  def json_response(body)
    ActiveSupport::JSON.decode(body)
  end


end