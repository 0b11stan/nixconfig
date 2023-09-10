{
  enable = true;
  profiles.custom = {
    bookmarks = {
      planner.url = "https://tasks.office.com";
      outlook.url = "https://outlook.office.com";
      teams.url = "https://teams.microsoft.com";
    };
    settings = {
      # Hide some search engines in top searchbar
      "browser.search.hiddenOneOffs" = "Google,Bing";
      # Set the download directory
      "browser.download.dir" = "/home/tristan/Downloads";
      # Ask where to download anyway
      "browser.download.useDownloadDir" = false;
      # Prefere websites to use dark theme
      "layout.css.prefers-color-scheme.content-override" = 0;
      # Send a "Do not track" signal to websites
      "privacy.donottrackheader.enabled" = true;
      # Disable mozilla telemetry
      "datareporting.healthreport.uploadEnabled" = false;
      # Disable mozilla studies
      "app.shield.optoutstudies.enabled" = false;
    };
  };
}
