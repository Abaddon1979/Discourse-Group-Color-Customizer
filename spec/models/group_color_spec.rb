# spec/models/group_color_spec.rb

require 'rails_helper'

RSpec.describe GroupColor, type: :model do
  describe ".cached_group_colors" do
    it "caches the group colors" do
      group = Group.first
      group_color = GroupColor.create!(group: group, color: "#123456", rank: 1)

      expect(Rails.cache).to receive(:fetch).with("group_color_customizer/group_colors", expires_in: 12.hours).and_call_original
      cached_colors = GroupColor.cached_group_colors

      expect(cached_colors).to include(group.name => { color: "#123456", rank: 1 })

      # Fetch again to ensure cache is used
      expect(Rails.cache).to_not receive(:fetch).with("group_color_customizer/group_colors", anything)
      cached_colors = GroupColor.cached_group_colors
    end

    it "invalidates the cache after save" do
      group = Group.first
      group_color = GroupColor.create!(group: group, color: "#123456", rank: 1)
      GroupColor.cached_group_colors

      expect(Rails.cache).to receive(:delete).with("group_color_customizer/group_colors")
      group_color.update!(color: "#654321")
    end
  end
end

