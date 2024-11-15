# app/models/group_color.rb

class GroupColor < ActiveRecord::Base
  belongs_to :group
  
  validates :color, presence: true
  validates :rank, presence: true, numericality: { only_integer: true, greater_than: 0 }
  
  after_save :clear_cache
  after_destroy :clear_cache
  
  def self.cached_group_colors
    Discourse.cache.fetch("group_colors", expires_in: 1.hour) do
      GroupColor.all.map { |gc| [gc.group_id, { name: gc.group.name, color: gc.color, rank: gc.rank }] }.to_h
    end
  end
  
  private
  
  def clear_cache
    Discourse.cache.delete("group_colors")
  end
end