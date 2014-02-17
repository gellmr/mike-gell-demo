worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)

# Here we define a request timeout for unicorn worker processes.
# This timeout is bigger than the "Rack::Timeout" defined in /initializers/timeout.rb
# We need both, because the Rack timeout gives a stacktrace, but is not always reliable.
# The unicorn timout (defined here) is reliable but gives no stacktrace.
# Workers MUST complete their request within the unicorn timeout.
# Otherwise, master will issue SIGKILL to worker.
# ...This will generate an H13 error code in heroku logs. It will NOT generate a stacktrace.
timeout 15

# Allows rapid startup, for unicorn "worker" processes.
# Allows us to define before_fork() and after_fork() for each "worker".
preload_app true

# TERM indicates the heroku dyno is going to shut down.
# Workers should ignore TERM.
# Master should intercept TERM and issue QUIT to itself and all workers.
# According to the heroku documentation at https://devcenter.heroku.com/articles/rails-unicorn
# each worker has (ten seconds) to gracefully end all in-flight transactions,
# before master issues KILL signal, to force worker shutdown.

before_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  # Master about to fork...disconnect from worker related services, eg database, redis, sidekiq
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  # Workers should only terminate if the master tells them to (gracefully)
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  # Workers init their connection to database, redis, sidekiq, etc.
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end