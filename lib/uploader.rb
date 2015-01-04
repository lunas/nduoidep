require 'rest_client'
require 'page_uploader'
require 'optparse'

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

  IMAGE_DIR = './page_images'
  IMAGE_PATTERN = '*.jpg'
  SERVER = 'http://www.nguoidepmagazine-ny.com'

  attr_reader :images, :errors

  def initialize(dir = IMAGE_DIR, image_pattern = IMAGE_PATTERN, server = SERVER)
    @image_dir = dir
    @image_pattern = image_pattern
    @base_addr = create_base_address(server)
    @images = read_image_dir
    @errors = []
    @page_uploader = PageUploader.new
    @num_processed = 0
  end

  def create_base_address(server)
    server = 'http://' + server unless server[0..3] == 'http'
    server = server.gsub(/\/$/,'') + '/api'
    server
  end

  def read_image_dir
    Dir.chdir(@image_dir)
    Dir[@image_pattern].map{ |f| File.expand_path(f) }
  end

  def show_results
    puts "Uploaded #{@num_processed} page images to AWS"
    if @errors.empty?
      puts "  with no errors."
    else
      puts "  with #{@errors.size} errors:"
      @errors.each do |error|
        puts "  - #{error}"
      end
    end
  end

  def run
    begin
      issue_id = create_issue
      @images.each do |image|
        create_and_upload_page(issue_id, image)
      end
    rescue => e
      @errors << e.message
    end
  end

  def create_and_upload_page(issue_id, image)
    begin
      page_id = create_page(issue_id, image)
      url = upload_to_aws(page_id, image)
      update_page(page_id, url)
      @num_processed += 1
      puts url
    rescue => e
      @errors << "#{e.message} \n    when processing image  #{image}"
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

  def get_issue_data
    puts 'Please enter data for this issue:'
    print 'Issue title: '
    title = STDIN.gets.chomp
    default_date = "#{Time.now.strftime("%Y.%m")}.01"
    print "Issue date (YYYY.MM.DD, default: #{default_date}): "
    user_date = STDIN.gets.chomp
    date =get_date_from(user_date, default_date)
    [title, date]
  end

  def get_date_from(user_date, default_date)
    if user_date.empty?
      default_date
    else
      begin
        Date.parse(user_date).strftime('%Y.%m.%d')
      rescue
        puts "Invalid date: #{user_date}. Going to use #{default_date}"
        default_date
      end
    end
  end

  # Creates a page on server, returns page_id.
  def create_page(issue_id, image)
    page_nr, title = parse_name(image)
    response = post( 'pages', {page:{issue_id: issue_id, page_nr: page_nr, title: title}})
    pid = json_response(response.body)['page_id']
    if pid.nil?
      raise StandardError, "Didn't get valid issue_id from server. Sent issue_id #{issue_id}, title #{title} and page_nr #{page_nr}."
    end
    pid
  end

  # Extract number and title from image filename
  def parse_name(image)
    filename = File.basename(image)
    nr = filename[0..2]
    # covers usually start with 000 and have a number later in the filename
    if nr == '000'
      nr_start_index = filename[3..-1] =~ /\d+/
      nr = $&.to_i                                  # $& holds the matched text from the last =~
      title_index = nr_start_index + $&.length + 3  # + 3 because we already cut the first three characters
    else
      nr = nr.to_i
      title_index = 3
    end
    raise StandardError, "Couldn't find page nr in image file name: #{filename}" unless nr > 0
    title = filename[title_index..-1].gsub(/(-Done|_Done|\.jpg|\.jpeg|\.png|\.gif)/i, '')
    title.gsub!( /^(_|-)/, '')    # chop leading _ or -
    [nr, title]
  end

  def parse_nr(filename)
    nr = filename[0..2]
    if nr == '000'
      nr = filename[3..-1] =~ /\d+/
    end
    nr = filename[0..2].to_i
    raise StandardError, "Couldn't find page nr in image file name: #{filename}" unless nr > 0

  end

  # Uploads image to aws and returns url.
  def upload_to_aws(page_id, image)
    @page_uploader.page_id = page_id
    file = File.open(image)
    @page_uploader.store!(file)
    @page_uploader.url
  end

  def update_page(page_id, url)
    post( "pages/#{page_id}", {url: url}, :put )
  end

  def post(path, params, method = :post)
    RestClient.send(method, get_url(path),
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