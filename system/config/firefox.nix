{
  enable = true;
  profiles.private = {
    id = 0;

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
              name = "Deep Jump";
              bookmarks = [
                {
                  name = "tiime";
                  url = "https://apps.tiime.fr/";
                }
              ];
            }
            {
              name = "tuta";
              url = "https://app.tuta.com/";
            }
            {
              name = "kdrive";
              url = "https://ksuite.infomaniak.com/";
            }
            {
              name = "consensus";
              url = "https://consensus.app/";
            }
            {
              name = "our world in data";
              url = "https://ourworldindata.org/";
            }
          ];
        }
      ];
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
      # Enable extensions by default
      "extensions.autoDisableScopes" = 0;
      # Disable saving passwords
      "signon.rememberSignons" = false;
    };
  };
}
