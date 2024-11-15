# lib/group_color_customizer/engine.rb

module GroupColorCustomizer
  class Engine < ::Rails::Engine
    engine_name PLUGIN_NAME
    isolate_namespace GroupColorCustomizer

    config.after_initialize do
      Discourse::Application.routes.append do
        mount ::GroupColorCustomizer::Engine, at: '/admin/plugins/group-color-customizer'
      end
    end
  end
end
