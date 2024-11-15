Discourse::Application.config.after_initialize do
  if defined?(Discourse::Application::ADMIN_PAGES)
    Discourse::Application::ADMIN_PAGES << {
      route: 'group-color-customizer',
      label: 'group_color_customizer.title',
      full_url: '/admin/plugins/group-color-customizer'
    }
  end
end