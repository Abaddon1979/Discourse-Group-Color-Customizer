Gem::Specification.new do |spec|
  spec.name          = "discourse-group-color-customizer"
  spec.version       = "0.1.0"
  spec.authors       = ["Abaddon"]
  spec.email         = ["pepverse@proton.me"]

  spec.summary       = "Customizes user group colors and displays group information in user cards."
  spec.description   = "A Discourse plugin that allows administrators to assign specific colors to user groups, display these colors across forums, chat, and user profiles, and manage group priorities to determine the color displayed for each user based on their highest-ranking group."
  spec.homepage      = "https://github.com/yourusername/discourse-group-color-customizer"
  spec.license       = "MIT"

  spec.required_ruby_version = ">= 2.7.0"

  spec.add_dependency "discourse", ">= 2.7.0"
end