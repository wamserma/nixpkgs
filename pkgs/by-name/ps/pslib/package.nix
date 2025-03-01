{
  lib,
  stdenv,
  fetchurl,
  cmake,
  pkg-config,
  zlib,
  libpng,
  libjpeg,
  giflib,
  libtiff,
}:

stdenv.mkDerivation rec {
  pname = "pslib";
  version = "0.4.8";

  src = fetchurl {
    name = "${pname}-snixource-${version}.tar.gz";
    url = "mirror://sourceforge/${pname}/${pname}-${version}.tar.gz";
    sha256 = "sha256-gaWNvBLuUUy0o+HWCOyG6KmzxDrYCY6PV3WbA/jjH64=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
  ];
  buildInputs = [
    zlib
    libpng
    libjpeg
    giflib
    libtiff
  ];

  env = lib.optionalAttrs stdenv.hostPlatform.isDarwin {
    NIX_CFLAGS_COMPILE = "-Wno-error=implicit-function-declaration";
  };

  doCheck = true;

  outputs = [
    "out"
    "dev"
    "doc"
  ];

  installPhase = ''
    mkdir -p $out/lib
    for path in *.dylib *.so *.so.* *.o *.o.*; do
      mv $path $out/lib/
    done
    mkdir -p $dev/include
    mv ../include/libps $dev/include
    if test -d nix-support; then
      mv nix-support $dev
    fi
    mkdir -p $doc/share/doc/${pname}
    cp -r ../doc/. $doc/share/doc/${pname}
  '';

  meta = with lib; {
    description = "C-library for generating multi page PostScript documents";
    homepage = "https://pslib.sourceforge.net/";
    changelog = "https://sourceforge.net/p/pslib/git/ci/master/tree/pslib/ChangeLog";
    license = licenses.gpl2;
    maintainers = with maintainers; [ ShamrockLee ];
    platforms = platforms.unix;
  };
}
