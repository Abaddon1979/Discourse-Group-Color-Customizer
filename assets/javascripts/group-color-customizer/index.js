// assets/javascripts/group-color-customizer/index.js

import { withPluginApi } from "discourse/lib/plugin-api";

export default {
  name: "group-color-customizer",

  initialize() {
    withPluginApi("0.8.7", (api) => {
      // Function to apply color to a username element
      const applyColor = (element, user) => {
        if (!user || !user.group_colors) return;

        // Determine the highest priority group (lowest rank number)
        let highestGroup = user.group_colors.reduce((prev, current) => {
          return prev.rank < current.rank ? prev : current;
        }, user.group_colors[0]);

        if (highestGroup) {
          element.style.color = highestGroup.color;

          // Add group information
          let groupSpan = document.createElement("span");
          groupSpan.classList.add("user-groups");
          user.group_colors.forEach((group) => {
            let span = document.createElement("span");
            span.classList.add("user-group");
            span.style.backgroundColor = group.color;
            span.textContent = group.name;
            groupSpan.appendChild(span);
          });

          // Avoid duplicating groupSpan
          if (!element.parentElement.querySelector(".user-groups")) {
            element.parentElement.appendChild(groupSpan);
          }
        }
      };

      // Set up Intersection Observer for lazy loading
      const observer = new IntersectionObserver((entries, obs) => {
        entries.forEach((entry) => {
          if (entry.isIntersecting) {
            const element = entry.target;
            const user = element.dataset.user
              ? JSON.parse(element.dataset.user)
              : null;
            applyColor(element, user);
            obs.unobserve(element);
          }
        });
      }, {
        root: null,
        rootMargin: "0px",
        threshold: 0.1
      });

      // Observe username elements in chat, forums, and user cards
      api.onPageChange(() => {
        // Chat usernames
        document.querySelectorAll(".chat-message-info__username").forEach((el) => {
          // Prepare user data
          let userName = el.querySelector(".chat-message-info__username__name").textContent.trim();
          let user = Site.currentSiteSettings.group_color_customizer_settings[userName] || null;

          // Store user data in dataset for access in observer
          el.dataset.user = JSON.stringify(user || {});

          // Observe the element
          observer.observe(el);
        });

        // Forum usernames
        document.querySelectorAll(".username a").forEach((el) => {
          let userName = el.textContent.trim();
          let user = Site.currentSiteSettings.group_color_customizer_settings[userName] || null;

          // Store user data in dataset for access in observer
          el.dataset.user = JSON.stringify(user || {});

          // Observe the element
          observer.observe(el);
        });

        // User card usernames
        document.querySelectorAll(".user-profile-link .name-username-wrapper").forEach((el) => {
          let userName = el.textContent.trim();
          let user = Site.currentSiteSettings.group_color_customizer_settings[userName] || null;

          // Store user data in dataset for access in observer
          el.dataset.user = JSON.stringify(user || {});

          // Observe the element
          observer.observe(el);
        });
      });

      // Modify user card component to include group information
      api.modifyClass("component:user-card", {
        pluginId: "group-color-customizer",

        buildAttrs() {
          this._super(...arguments);
          let user = this.get("user");
          if (user && user.group_colors) {
            this.set("group_colors", user.group_colors);
          }
        }
      });
    });
  }
};
