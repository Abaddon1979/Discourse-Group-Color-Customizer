# app\assets\controllers\admin\group_color_customizer_controller.rb

module Admin
  class GroupColorCustomizerController < Admin::AdminController
    requires_plugin 'discourse-group-color-customizer'

    def index
      @groups = Group.all
      @group_colors = GroupColor.all.index_by(&:group_id)
    end

    def update
      params.require(:group_colors).permit!

      params[:group_colors].each do |group_id, attributes|
        group_color = GroupColor.find_or_initialize_by(group_id: group_id)
        group_color.color = attributes[:color]
        group_color.rank = attributes[:rank].to_i
        group_color.save!
      end

      flash[:success] = I18n.t('group_color_customizer.save')
      redirect_to admin_group_color_customizer_path
    end
  end
end

