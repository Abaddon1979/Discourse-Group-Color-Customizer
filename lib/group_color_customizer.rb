# lib/group_color_customizer.rb

# name: discourse-group-color-customizer
# about: Customizes user group colors and displays group information in user cards
# version: 0.1.0
# authors: Abaddon
# url: https://github.com/yabaddon1979/discourse-group-color-customizer

enabled_site_setting :group_color_customizer_enabled

register_asset "stylesheets/common/group-color-customizer.scss"
register_asset "javascripts/group-color-customizer/index.js"

# Register the plugin's engine
require_relative "discourse_group_color_customizer/engine"

# Initialize the plugin after Discourse loads
after_initialize do
  # Include GroupColor model
  require_dependency "group_color"

  # Add GroupColor model
  class ::GroupColor < ActiveRecord::Base
    belongs_to :group
    validates :color, presence: true, format: { with: /\A#[0-9A-Fa-f]{6}\z/, message: "must be a valid hex color code" }
    validates :rank, presence: true, numericality: { only_integer: true, greater_than: 0 }

    # Fetch all group colors with caching
    def self.cached_group_colors
      GroupColorCustomizer::Cache.fetch_group_colors
    end

    # Invalidate cache when group colors are updated
    after_save :invalidate_cache
    after_destroy :invalidate_cache

    private

    def invalidate_cache
      GroupColorCustomizer::Cache.invalidate_group_colors
    end
  end

  # Register group color custom fields
  Group.register_custom_field_type('group_color_customizer_color', :string)
  Group.register_custom_field_type('group_color_customizer_rank', :integer)

  # Add to serializer using cached group colors
  add_to_serializer(:user, :group_colors) do
    GroupColor.cached_group_colors.select { |group_name, _| object.groups.pluck(:name).include?(group_name) }
                       .map { |name, data| { name: name, color: data[:color], rank: data[:rank] } }
  end

  # Customize username rendering based on group color
  require_relative "discourse_group_color_customizer/hooks"
end