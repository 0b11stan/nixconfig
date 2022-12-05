{
  lib,
  stdenv,
  fetchurl,
  jdk11,
  runtimeShell,
  unzip,
  chromium,
}:
stdenv.mkDerivation rec {
  pname = "burpsuite";
  version = "2022.11.3";

  src = fetchurl {
    name = "burpsuite.jar";
    url = "https://portswigger-cdn.net/burp/releases/download?product=pro&version=${version}&type=Jar";
    sha256 = "sha256-SkH7+KmwKgVvY9p+iBubTQYnwOzIHIMZakBZG5HUf60=";
  };

  dontUnpack = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    echo '#!${runtimeShell}
    eval "$(${unzip}/bin/unzip -p ${src} chromium.properties)"
    mkdir -p "$HOME/.BurpSuite/burpbrowser/$linux64"
    ln -sf "${chromium}/bin/chromium" "$HOME/.BurpSuite/burpbrowser/$linux64/chrome"
    export _JAVA_AWT_WM_NONREPARENTING=1
    exec ${jdk11}/bin/java -jar ${src} "$@"' > $out/bin/burpsuite
    chmod +x $out/bin/burpsuite
    runHook postInstall
  '';

  preferLocalBuild = true;
}
