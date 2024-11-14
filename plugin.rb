# plugin.rb

# name: Discourse-Group-Color-Customizer
# about: Customizes user group colors and displays group information in user cards
# version: 0.1.0
# authors: Abaddon
# url: https://github.com/Abaddon1979/discourse-group-color-customizer

enabled_site_setting :group_color_customizer_enabled

# Ensure the cache module is loaded
after_initialize do
  require File.expand_path('../lib/group_color_customizer/cache.rb', __FILE__)

  # Add color data to user serializer
  add_to_serializer(:user, :group_colors) do
    begin
      group_colors = GroupColor.cached_group_colors
      object.groups.map do |group|
        name = group.name
        data = group_colors[group.id] # Ensuring we're fetching by Group ID
        next unless data

        { name: data[:name], color: data[:color], rank: data[:rank] }
      end.compact
    rescue => e
      Rails.logger.error("Error serializing group_colors: #{e.message}")
      []
    end
  end

  # Hook to ensure new groups get a default color
  Group.class_eval do
    after_create do
      GroupColor.where(group_id: self.id).first_or_create!(
        color: "#000000", # Default color
        rank: 1           # Default rank
      )
    end
  end
end