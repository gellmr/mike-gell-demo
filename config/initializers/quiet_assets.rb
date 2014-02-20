# Suppress the huge list of GET messages 
# which are fired when we first load a page:

#   Started GET "/assets/auth.css?body=1" for 127.0.0.1 at 2014-02-20 11:40:04 +0800
#   Started GET "/assets/body.css?body=1" for 127.0.0.1 at 2014-02-20 11:40:04 +0800
#   Started GET "/assets/home.css?body=1" for 127.0.0.1 at 2014-02-20 11:40:04 +0800
#   Started GET "/assets/navbar.css?body=1" for 127.0.0.1 at 2014-02-20 11:40:04 +0800
#   Started GET "/assets/jquery_ujs.js?body=1" for 127.0.0.1 at 2014-02-20 11:40:04 +0800
#   Started GET "/assets/application.css?body=1" for 127.0.0.1 at 2014-02-20 11:40:04 +0800
#   ...etc

if Rails.env.development?
  Rails.application.assets.logger = Logger.new('/dev/null')
  Rails::Rack::Logger.class_eval do
    def call_with_quiet_assets(env)
      previous_level = Rails.logger.level
      Rails.logger.level = Logger::ERROR if env['PATH_INFO'] =~ %r{^/assets/}
      call_without_quiet_assets(env)
    ensure
      Rails.logger.level = previous_level
    end
    alias_method_chain :call, :quiet_assets
  end
end