require 'factory_girl'
# See: http://xtargets.com/2011/02/06/seeding-your-rails-db-with-factory-girl/
Dir[Rails.root.join('db', 'seeds', '*.rb').to_s].sort.each do |file|
  puts "Loading db/seeds/#{file.split(File::SEPARATOR).last}"
  load(file)
end
