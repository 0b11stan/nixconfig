{pkgs}: {
  id = 3;

  search = {
    force = true;
    default = "ddg";
    engines = {
      "bing".metaData.hidden = true;
      "google".metaData.hidden = true;
    };
  };

  bookmarks = {
    force = true;
    settings = [
      {
        toolbar = true;
        bookmarks = [
          {
            name = "tiime";
            url = "https://apps.tiime.fr/";
          }
          {
            name = "kdrive";
            url = "https://ksuite.infomaniak.com/";
          }
        ];
      }
    ];
  };

  settings = {
    # Hide some search engines in top searchbar
    "browser.search.hiddenOneOffs" = "Google,Bing";
    # Set the download directory
    "browser.download.dir" = "/home/tristan/Downloads/deepjump/";
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
    # Enable extensions by default
    "extensions.autoDisableScopes" = 0;
    # Disable saving passwords
    "signon.rememberSignons" = false;
  };
}
