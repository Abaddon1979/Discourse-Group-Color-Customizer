# plugin.rb

# name: Discourse-Group-Color-Customizer
# about: Customizes user group colors and displays group information in user cards
# version: 0.1.0
# authors: Abaddon
# url: https://github.com/Abaddon1979/discourse-group-color-customizer

enabled_site_setting :group_color_customizer_enabled

PLUGIN_NAME ||= "discourse-group-color-customizer".freeze

# Load dependencies
load File.expand_path('../lib/group_color_customizer/engine.rb', __FILE__)

after_initialize do
  # Load models and controllers
  require_dependency 'application_controller'
  require_dependency File.expand_path('../app/models/group_color.rb', __FILE__)
  
  # Add migration if needed
  if !ActiveRecord::Base.connection.table_exists?('group_colors')
    migration_class = ActiveRecord::Migration.try(:[], 5.2) || ActiveRecord::Migration
    class ::CreateGroupColors < migration_class
      def up
        create_table :group_colors do |t|
          t.integer :group_id, null: false
          t.string :color, null: false, default: '#000000'
          t.integer :rank, null: false, default: 0
          t.timestamps null: false
        end
        add_index :group_colors, :group_id, unique: true
      end

      def down
        drop_table :group_colors
      end
    end

    CreateGroupColors.new.up
  end

  # Add plugin to admin menu
  add_admin_route 'group_color_customizer.title', 'group-color-customizer'

  # Add to admin menu
  Discourse::Application.routes.append do
    namespace :admin, constraints: StaffConstraint.new do
      mount ::GroupColorCustomizer::Engine, at: '/group-color-customizer'
    end
  end
end