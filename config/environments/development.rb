PenpalSampleRails::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # These 2 lines auto-reload penpal
  # This first line adds our gem's lib directory to the list of directories that will be searched
  # when we encounter a missing constant
 # config.autoload_paths += %W(#{Rails.root}/../penpal-ruby/lib)
  # This line tells rails to unload the root constant (module/class) for our gem on every request
#  ActiveSupport::Dependencies.explicitly_unloadable_constants << 'Penpal'
#  ActiveSupport::Dependencies.mark_for_unload 'Penpal'
#  ActiveSupport::Dependencies.autoload_once_paths.delete(%W(#{Rails.root}/../penpal-ruby/lib))
end
