{
  stdenv,
  lib,
  fetchurl,
  makeWrapper,
  pkgs,
}:
stdenv.mkDerivation rec {
  pname = "BloodHound";
  version = "4.2.0";
  arch = "x64";

  src = fetchurl {
    url = "https://github.com/BloodHoundAD/BloodHound/releases/download/${version}/BloodHound-linux-${arch}.zip";
    sha256 = "sha256-mKo1wx9ByVpVFrDLtSv21Cn5aRnWZcakWomlVZVQY5w=";
  };

  nativeBuildInputs = [
    makeWrapper
    pkgs.which
    pkgs.unzip
  ];

  dontConfigure = true;
  dontBuild = true;

  unpackCmd = "unzip ${src}";

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/opt/bloodhound $out/share/bloodhound
    cp -r . $out/opt/bloodhound
    makeWrapper $out/opt/bloodhound/BloodHound $out/bin/bloodhound \
      --prefix LD_LIBRARY_PATH : ${LD_LIBRARY_PATH}:$out/opt/bloodhound/

    patchelf --set-interpreter $(patchelf --print-interpreter `which cp`) \
      $out/opt/bloodhound/BloodHound

    runHook postInstall
  '';

  LD_LIBRARY_PATH = with pkgs;
    lib.makeLibraryPath [
      glib
      nss
      nspr
      atk
      at-spi2-atk
      at-spi2-core
      cairo
      expat
      gdk-pixbuf
      gtk3
      libdrm
      mesa
      pango
      xorg.libX11
      xorg.libxcb
      xorg.libXcomposite
      xorg.libXdamage
      xorg.libXext
      xorg.libXfixes
      xorg.libXrandr
      libxkbcommon
      alsa-lib
      dbus
      cups
    ];
}
