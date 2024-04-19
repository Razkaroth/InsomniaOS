{ inputs, pkgs, ... }: {
  home = {
    sessionVariables = {
      BROWSER = "google-chrome-stable";
    };
    file."firefox-gnome-theme" = {
      target = ".mozilla/firefox/default/chrome/firefox-gnome-theme";
      source = inputs.firefox-gnome-theme;
    };
    packages = with pkgs; [
      libsForQt5.plasma-browser-integration
    ];
  };
   xdg.desktopEntries.google-chrome-offloaded = {
     name = "Google Chrome Offloaded";
     exec = "nvidia-offload google-chrome-stable";
     icon = "google-chrome-stable";
     categories = [ "Network" "WebBrowser" ];
    };

    xdg.desktopEntries.brave = {
      name="Brave";
      exec = "nvidia-offload brave";
      noDisplay = true;
    };

  programs.firefox = {
    enable = true;
    profiles.default = {
      name = "Default";
      settings = {
        "accessibility.typeaheadfind.manual" = false;
        "accessibility.typeaheadfind.autostart" = false;
        "browser.tabs.loadInBackground" = true;
        "browser.tabs.loadBookmarksInBackground" = true;
        "toolkit.tabbox.switchByScrolling" = true;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "svg.context-properties.content.enabled" = true;

        "gnomeTheme.hideSingleTab" = true;
        "gnomeTheme.bookmarksToolbarUnderTabs" = true;
        "gnomeTheme.normalWidthTabs" = false;
        "gnomeTheme.tabsAsHeaderbar" = false;
      };
      userChrome = ''
        @import "firefox-gnome-theme/userChrome.css";
      '';
      userContent = ''
        @import "firefox-gnome-theme/userContent.css";
      '';
    };
    nativeMessagingHosts = [
      pkgs.plasma-browser-integration
      pkgs.browserpass
    ];
  };
}
