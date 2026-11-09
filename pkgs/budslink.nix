{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
, pkg-config
, gobject-introspection
, wrapGAppsHook4
, desktop-file-utils
, gjs
, gtk4
, libadwaita
, glib
, libpulseaudio
, bluez
}:

stdenv.mkDerivation rec {
  pname = "budslink";
  version = "0.2.2";

  src = fetchFromGitHub {
    owner = "maniacx";
    repo = "BudsLink";
    rev = "0eb4d07dcd7eafabf425d98c607e02fc9519c94b";
    fetchSubmodules = true;
    hash = "sha256-laDpQaVIdhLA9iIXt56G8h+MD7XFKdYU+7Yui/2CHM4=";
  };

  patches = [
    ../patches/0001-support-oneplus-nord-buds-3-and-universal-fallback.patch
  ];

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
    gobject-introspection
    wrapGAppsHook4
    desktop-file-utils
  ];

  buildInputs = [
    glib
    gjs
    gtk4
    libadwaita
    libpulseaudio
    bluez
  ];

  meta = with lib; {
    description = "Battery status and ANC control for various Bluetooth earbuds on Linux";
    homepage = "https://github.com/maniacx/BudsLink";
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    mainProgram = "budslink";
  };
}
