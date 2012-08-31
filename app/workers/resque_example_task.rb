class ResqueExampleTask
  @queue = :example_queue
  def self.perform(message)
  puts message
  # TODO: Add your background tasks like this
  #  snippet = Snippet.find(snippet_id)
  #  uri = URI.parse('http://pygments.appspot.com/')
  #  request = Net::HTTP.post_form(uri, {'lang' => snippet.language, 'code' => snippet.plain_code})
  #  snippet.update_attribute(:highlighted_code, request.body)
  end
end
