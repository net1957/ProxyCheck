# frozen_string_literal: true

# Suppress login for health checks
# see https://omohikane.com/rails_disable_request_log/
class AppLogger < Rails::Rack::Logger
  def call(env)
    %r{/health}i.match?(env['REQUEST_PATH']) ? Rails.logger.silence { super } : super
  end

  Rails.application.config.middleware.swap Rails::Rack::Logger, AppLogger
end
