# config/initializers/timeout.rb

# If a request exceeds _ seconds, close request and generate stacktrace in the heroku logs.
# This method (Rack::Timeout) can be unreliable, so we ALSO define a (bigger) __ second timeout
# for all unicorn worker processes. If the request is NOT completed in __ seconds, the unicorn worker
# process is killed with H13 error code, but no stack trace. See /config/unicorn.rb

Rack::Timeout.timeout = 10  # seconds. (Can be unreliable)