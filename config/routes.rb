# config/routes.rb

GroupColorCustomizer::Engine.routes.draw do
  get '/' => 'admin/group_color_customizer#index', as: 'admin_group_color_customizer'
  post '/' => 'admin/group_color_customizer#update'
end