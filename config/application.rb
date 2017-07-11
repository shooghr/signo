require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Signo
  class Application < Rails::Application
    config.time_zone = 'Brasilia'
    config.filter_parameters << :password

    config.i18n.available_locales = [:"pt-BR"]
    config.i18n.default_locale = :"pt-BR"
    I18n.config.enforce_available_locales = false
    config.encoding = 'utf-8'
    Time::DATE_FORMATS[:default] = '%d/%m/%Y %H:%M'
    Date::DATE_FORMATS[:default] = '%d/%m/%Y'

    config.assets.paths << "#{Rails.root}/public/admin"
    config.autoload_paths += %W(#{config.root}/app/validators #{config.root}/app/controllers/before_actions)
    config.active_record.raise_in_transactional_callbacks = true

    config.action_dispatch.default_headers = {
      'Access-Control-Allow-Origin' => '*',
      'Access-Control-Request-Method' => '*'
    }

    config.generators do |g|
      g.stylesheets false
      g.test_framework :rspec, fixture: true
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.view_specs false
      g.helper_specs true
      g.integration_tool :rspec
    end
  end
end
