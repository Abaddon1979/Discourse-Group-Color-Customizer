# plugin.rb

# name: Discourse-Group-Color-Customizer
# about: Customizes user group colors and displays group information in user cards
# version: 0.1.0
# authors: Abaddon
# url: https://github.com/Abaddon1979/discourse-group-color-customizer

enabled_site_setting :group_color_customizer_enabled

after_initialize do
  # Add plugin's app/models to the autoload paths
  Rails.configuration.autoload_paths += [File.expand_path('app/models', __dir__)]

  # Ensure the migrations are picked up
  Rails.configuration.paths['db/migrate'] << File.expand_path('db/migrate', __dir__)

  # Include models
  require_dependency File.expand_path('app/models/group_color.rb', __dir__)

  # Your plugin initialization code...
end
