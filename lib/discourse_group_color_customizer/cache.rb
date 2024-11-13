# lib/discourse_group_color_customizer/cache.rb

module GroupColorCustomizer
    module Cache
      CACHE_KEY = "group_color_customizer/group_colors".freeze
      CACHE_EXPIRY = 12.hours
  
      def self.fetch_group_colors
        Rails.cache.fetch(CACHE_KEY, expires_in: CACHE_EXPIRY) do
          GroupColor.all.includes(:group).map { |gc| [gc.group.name, { color: gc.color, rank: gc.rank }] }.to_h
        end
      end
  
      def self.invalidate_group_colors
        Rails.cache.delete(CACHE_KEY)
      end
    end
  end
  