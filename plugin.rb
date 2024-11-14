# plugin.rb

# name: Discourse-Group-Color-Customizer
# about: Customizes user group colors and displays group information in user cards
# version: 0.1.0
# authors: Abaddon
# url: https://github.com/Abaddon1979/discourse-group-color-customizer


enabled_site_setting :group_color_customizer_enabled

# Load the plugin's engine for routing and other configurations
load File.expand_path('lib/group_color_customizer/engine.rb', __dir__)

# Add the plugin's model and controller paths using Discourse plugin API methods
add_model_path File.expand_path('app/models', __dir__)
add_controller_path File.expand_path('app/controllers', __dir__)

after_initialize do
  # Plugin initialization code can be added here if needed
  # For example, you can define plugin-specific settings or behavior

  # Example: Add custom serializers or modify existing ones
  add_to_serializer(:user, :group_colors) do
    GroupColor.cached_group_colors.select { |group_name, _| object.groups.pluck(:name).include?(group_name) }
                                   .map { |name, data| { name: name, color: data[:color], rank: data[:rank] } }
  end
end