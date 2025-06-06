{
  lib,
  rustPlatform,
  fetchFromGitHub,
  cmake,
  pkg-config,
  openssl,
  samba,
}:

rustPlatform.buildRustPackage rec {
  pname = "legba";
  version = "0.10.0";

  src = fetchFromGitHub {
    owner = "evilsocket";
    repo = "legba";
    rev = "v${version}";
    hash = "sha256-ioH/dy+d20p81iLLIcer+1fVib60TJ5Ezr6UlsL+F9g=";
  };

  useFetchCargoVendor = true;
  cargoHash = "sha256-eIgi6+f7ss/5AB3llEfrS75twejFzReS4i7fdbGWrCk=";

  nativeBuildInputs = [
    cmake
    pkg-config
  ];
  buildInputs = [
    openssl.dev
    samba
  ];

  # Paho C test fails due to permission issue
  doCheck = false;

  meta = {
    description = "Multiprotocol credentials bruteforcer / password sprayer and enumerator";
    homepage = "https://github.com/evilsocket/legba";
    changelog = "https://github.com/evilsocket/legba/releases/tag/v${version}";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ mikaelfangel ];
    mainProgram = "legba";
  };
}
