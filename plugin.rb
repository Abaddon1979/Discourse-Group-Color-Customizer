# plugin.rb

# name: Discourse-Group-Color-Customizer
# about: Customizes user group colors and displays group information in user cards
# version: 0.1.0
# authors: Abaddon
# url: https://github.com/Abaddon1979/discourse-group-color-customizer

enabled_site_setting :group_color_customizer_enabled

after_initialize do
  # The necessary components of your plugin are loaded by Rails and Discourse's autoload system,
  # as the files are placed within the app directory structure.
  
  # Example: Add custom serializers or modify existing ones
  add_to_serializer(:user, :group_colors) do
    GroupColor.cached_group_colors.select { |group_name, _| object.groups.map(&:name).include?(group_name) }
                                   .map { |name, data| { name: name, color: data[:color], rank: data[:rank] } }
  end

  # Load the plugin's engine (this might be redundant if already loaded)
  # load File.expand_path('lib/group_color_customizer/engine.rb', __dir__)
end