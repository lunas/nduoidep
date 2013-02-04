#require "resque/tasks"

# Make sure redis server is installed on localhost:
# brew install redis
# Then run Redis server with:
# redis-server /usr/local/etc/redis.conf
# To execute tasks on all background queues, on another terminal execute:
# rake resque:work QUEUE='*'
# Learn more here: http://railscasts.com/episodes/271-resque

# This will load up the entire rails environment so we have access to all
# rails models.  This can be slow, so if a task doesn't require rails,
# comment this out and do something custom here.
#task "resque:setup" => :environment
