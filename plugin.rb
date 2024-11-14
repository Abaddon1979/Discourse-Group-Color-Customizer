# plugin.rb

# name: Discourse-Group-Color-Customizer
# about: Customizes user group colors and displays group information in user cards
# version: 0.1.0
# authors: Abaddon
# url: https://github.com/Abaddon1979/discourse-group-color-customizer

enabled_site_setting :group_color_customizer_enabled

after_initialize do
  # Add to user serializer
  add_to_serializer(:user, :group_colors) do
    GroupColor.cached_group_colors
      .select { |group_name, _| object.groups.map(&:name).include?(group_name) }
      .map { |name, data| { name: name, color: data[:color], rank: data[:rank] } }
  end

  # Callback to create a corresponding GroupColor entry for each new group
  Group.class_eval do
    after_create :ensure_group_color_presence

    def ensure_group_color_presence
      GroupColor.where(group_id: self.id).first_or_create!(
        color: "#000000",  # Default color
        rank: 1            # Default rank
      )
    end
  end
end