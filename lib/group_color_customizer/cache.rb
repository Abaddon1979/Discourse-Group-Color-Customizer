# lib/group_color_customizer/cache.rb

module GroupColorCustomizer
  module Cache
    def self.fetch_group_colors
      Rails.cache.fetch("group_colors", expires_in: 12.hours) do
        GroupColor.all.inject({}) do |result, group_color|
          if group_color.group
            result[group_color.group.id] = { name: group_color.group.name, color: group_color.color, rank: group_color.rank }
          end
          result
        end
      end
    end

    def self.invalidate_group_colors
      Rails.cache.delete("group_colors")
    end
  end
end