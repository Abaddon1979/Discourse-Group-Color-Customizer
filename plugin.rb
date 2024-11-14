# plugin.rb

# name: discourse-group-color-customizer
# about: Customizes user group colors and displays group information in user cards
# version: 0.1.0
# authors: Abaddon
# url: https://github.com/Abaddon1979/discourse-group-color-customizer

enabled_site_setting :group_color_customizer_enabled

# Register assets
register_asset "javascripts/group-color-customizer.js"

# Specify the migration path
add_migration_path "db/migrate"

# Load the engine
load File.expand_path('lib/group_color_customizer/engine.rb', __dir__)

after_initialize do
  # Plugin initialization code goes here
end
