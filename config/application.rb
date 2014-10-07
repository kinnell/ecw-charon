require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(*Rails.groups)

module Charon
  class Application < Rails::Application

    config.time_zone = 'Eastern Time (US & Canada)'
    config.active_record.default_timezone = :local

  end
end
