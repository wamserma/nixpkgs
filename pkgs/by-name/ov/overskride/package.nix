{
  lib,
  fetchFromGitHub,
  rustPlatform,
  cargo,
  rustc,
  meson,
  ninja,
  pkg-config,
  wrapGAppsHook4,
  desktop-file-utils,
  appstream-glib,
  blueprint-compiler,
  dbus,
  gtk4,
  libadwaita,
  bluez,
  libpulseaudio,
}:
let

  owner = "kaii-lb";
  name = "overskride";
  version = "0.6.1";

in
rustPlatform.buildRustPackage {

  pname = name;
  inherit version;

  src = fetchFromGitHub {
    inherit owner;
    repo = name;
    rev = "v${version}";
    hash = "sha256-SqaPhub/HwZz7uBg/kevH8LvPDVLgRd/Rvi03ivNrRc=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-Axeywo7Ryig84rS/6MXl2v9Pe3yzdivq7/l/mfi5mOA=";

  nativeBuildInputs = [
    pkg-config
    wrapGAppsHook4
    desktop-file-utils
    appstream-glib
    blueprint-compiler
    meson
    ninja
    cargo
    rustc
  ];

  buildInputs = [
    dbus
    gtk4
    libadwaita
    bluez
    libpulseaudio
  ];

  buildPhase = ''
    runHook preBuild

    meson setup build --prefix $out && cd build
    meson compile && meson devenv

    runHook postBuild
  '';

  # The "Validate appstream file" test fails.
  # TODO: This appears to have been fixed upstream
  # so checks should be enabled with the next version.
  doCheck = false;

  preFixup = ''
    glib-compile-schemas $out/share/gsettings-schemas/${name}-${version}/glib-2.0/schemas
  '';

  meta = {
    description = "Bluetooth and Obex client that is straight to the point, DE/WM agnostic, and beautiful";
    homepage = "https://github.com/${owner}/${name}";
    changelog = "https://github.com/${owner}/${name}/blob/v${version}/CHANGELOG.md";
    license = lib.licenses.gpl3Only;
    mainProgram = name;
    maintainers = with lib.maintainers; [ mrcjkb ];
    platforms = lib.platforms.linux;
  };

}
