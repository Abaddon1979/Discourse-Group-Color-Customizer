# lib/discourse_group_color_customizer/hooks.rb

DiscourseGroupColorCustomizer::Engine.routes.draw do
    namespace :admin do
      get "/group-color-customizer", to: "group_color_customizer#index"
      post "/group-color-customizer", to: "group_color_customizer#update"
    end
  end
  
  after_initialize do
    # Register admin route
    Discourse::Application.routes.append do
      namespace :admin do
        mount ::DiscourseGroupColorCustomizer::Engine, at: "/group-color-customizer"
      end
    end
  
    # Customize user display in chat, forums, and user cards
    add_to_serializer(:user, :group_colors) do
      GroupColor.cached_group_colors.select { |group_name, _| object.groups.pluck(:name).include?(group_name) }
                         .map { |name, data| { name: name, color: data[:color], rank: data[:rank] } }
    end
  end
  