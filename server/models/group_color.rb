# server/models/group_color.rb

class GroupColor < ActiveRecord::Base
    belongs_to :group
  
    validates :color, presence: true, format: { with: /\A#[0-9A-Fa-f]{6}\z/, message: "must be a valid hex color code" }
    validates :rank, presence: true, numericality: { only_integer: true, greater_than: 0 }
  
    after_save :invalidate_cache
    after_destroy :invalidate_cache
  
    def self.cached_group_colors
      GroupColorCustomizer::Cache.fetch_group_colors
    end
  
    private
  
    def invalidate_cache
      GroupColorCustomizer::Cache.invalidate_group_colors
    end
  end
  