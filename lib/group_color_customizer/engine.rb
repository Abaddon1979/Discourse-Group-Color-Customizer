# lib/group_color_customizer/engine.rb

module GroupColorCustomizer
  class Engine < ::Rails::Engine
    engine_name 'group_color_customizer'
    isolate_namespace GroupColorCustomizer

    initializer 'group_color_customizer.append_routes' do
      Discourse::Application.routes.append do
        mount ::GroupColorCustomizer::Engine, at: "/app/assets/views/admin/group_color_customizer",
                                              constraints: AdminConstraint.new
      end
    end
  end
end
