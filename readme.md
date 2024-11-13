# Discourse Group Color Customizer

## Overview

**Discourse Group Color Customizer** is a plugin for Discourse that allows administrators to assign specific colors to user groups. These colors are reflected across forums, chat, and user profiles. Additionally, administrators can manage group priorities to determine which color is displayed when a user belongs to multiple groups.

## Features

- Assign custom colors to user groups.
- Display group colors in forums, chat, and user profiles.
- Manage group priorities to determine the color displayed for each user.
- Display all user groups in the user card.
- Hover over usernames in chat to reveal fading user cards with group information.
- **Performance Enhancements:**
  - **Caching:** Reduces database queries by caching group color information.
  - **Lazy Loading:** Applies color customizations only when elements enter the viewport, minimizing unnecessary DOM manipulations.

## Installation

1. **Add the Plugin:**

   Add the plugin to your Discourse installation by adding the following line to your `plugins` array in `app.yml`:

   ```yaml
   - git:
       url: https://github.com/yourusername/discourse-group-color-customizer.git
       ref: main
   ```

2. **Run Bundle Install:**

   ```bash
   ./launcher rebuild app
   ```

3. **Run Database Migrations:**

   The migration will run automatically when you rebuild the app.

4. **Enable the Plugin:**

   Navigate to the Discourse admin panel, go to **Settings**, and ensure that the plugin is enabled.

## Usage

1. **Navigate to Admin Settings:**

   Go to `https://yourdiscourse.site/admin/group-color-customizer`.

2. **Assign Colors and Ranks:**

   - For each user group, select a color using the color picker.
   - Assign a rank (lower number means higher priority).

3. **Save Changes:**

   Click the "Save Changes" button to apply your settings.

## Performance Enhancements

### **Caching**

- **Purpose:** Reduces the number of database queries by storing group color information in the Rails cache.
- **Implementation:** Group colors are cached for 12 hours. The cache is invalidated automatically when group colors are updated.
- **Benefit:** Enhances performance, especially in communities with a large number of users and groups.

### **Lazy Loading**

- **Purpose:** Applies color customizations only when username elements enter the viewport.
- **Implementation:** Utilizes the Intersection Observer API to detect when elements become visible and applies styles dynamically.
- **Benefit:** Minimizes unnecessary DOM manipulations, leading to faster initial page loads and enhanced client-side performance.

## Contributing

Contributions are welcome! Please open issues and submit pull requests for enhancements and bug fixes.

## License

This plugin is licensed under the MIT License.

## Acknowledgements

- Built using the Discourse Plugin API.
- Thanks to the Discourse community for guidance and support.