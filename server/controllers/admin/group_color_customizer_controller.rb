# server/controllers/admin/group_color_customizer_controller.rb

module DiscourseGroupColorCustomizer
  class GroupColorCustomizerController < ::Admin::AdminController
    requires_plugin "discourse-group-color-customizer"

    def index
      @groups = Group.all.order(:name)
      @group_colors = GroupColor.cached_group_colors
      render '/admin/group_color_customizer/index'
    end

    def update
      params[:group_colors].each do |group_id, attributes|
        group = Group.find(group_id)
        group_color = GroupColor.find_or_initialize_by(group: group)
        group_color.color = attributes[:color]
        group_color.rank = attributes[:rank].to_i
        group_color.save!
      end

      redirect_to "/admin/group-color-customizer" and return
    end
  end
end
