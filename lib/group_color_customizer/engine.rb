# lib/group_color_customizer/engine.rb

module GroupColorCustomizer
  class Engine < ::Rails::Engine
    engine_name 'group_color_customizer'
    isolate_namespace GroupColorCustomizer

    initializer 'group_color_customizer.append_routes' do
      Discourse::Application.routes.append do
        mount ::GroupColorCustomizer::Engine, at: "/admin/plugins/group-color-customizer",
                                              constraints: AdminConstraint.new
      end
    end

    routes.draw do
      get '/' => 'admin/group_color_customizer#index', as: 'admin_group_color_customizer'
      post '/' => 'admin/group_color_customizer#update'
    end
  end
end
