{
  fetchurl,
  lib,
  virtualbox,
}:
let
  virtualboxExtPackVersion = "7.1.12";
in
fetchurl rec {
  name = "Oracle_VirtualBox_Extension_Pack-${virtualboxExtPackVersion}.vbox-extpack";
  url = "https://download.virtualbox.org/virtualbox/${virtualboxExtPackVersion}/${name}";
  sha256 =
    # Manually sha256sum the extensionPack file, must be hex!
    # Thus do not use `nix-prefetch-url` but instead plain old `sha256sum`.
    # Checksums can also be found at https://www.virtualbox.org/download/hashes/${version}/SHA256SUMS
    let
      value = "c7ed97f4755988ecc05ec633475e299bbc1e0418cc3d143747a45c99df53abd3";
    in
    assert (builtins.stringLength value) == 64;
    value;

  meta = with lib; {
    description = "Oracle Extension pack for VirtualBox";
    license = licenses.virtualbox-puel;
    homepage = "https://www.virtualbox.org/";
    maintainers = with maintainers; [
      sander
      friedrichaltheide
    ];
    platforms = [ "x86_64-linux" ];
  };
}
