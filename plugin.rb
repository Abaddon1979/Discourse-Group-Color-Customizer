# plugin.rb

# name: Discourse-Group-Color-Customizer
# about: Customizes user group colors and displays group information in user cards
# version: 0.1.0
# authors: Abaddon
# url: https://github.com/Abaddon1979/discourse-group-color-customizer

enabled_site_setting :group_color_customizer_enabled

# Register assets
register_asset "stylesheets/group-color-customizer.scss"

# Load the engine
load File.expand_path('lib/group_color_customizer/engine.rb', __dir__)

after_initialize do
  # Plugin initialization code goes here
end
