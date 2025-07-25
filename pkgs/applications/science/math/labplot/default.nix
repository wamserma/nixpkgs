{
  lib,
  stdenv,
  fetchpatch,
  fetchurl,
  cmake,
  extra-cmake-modules,
  shared-mime-info,
  wrapQtAppsHook,

  qtbase,

  karchive,
  kcompletion,
  kconfig,
  kcoreaddons,
  kcrash,
  kdoctools,
  ki18n,
  kiconthemes,
  kio,
  knewstuff,
  kparts,
  ktextwidgets,
  kxmlgui,
  syntax-highlighting,

  gsl,

  poppler,
  fftw,
  hdf5,
  netcdf,
  cfitsio,
  libcerf,
  cantor,
  zlib,
  lz4,
  readstat,
  matio,
  qtserialport,
  discount,
}:

stdenv.mkDerivation rec {
  pname = "labplot";
  version = "2.10.1";

  src = fetchurl {
    url = "mirror://kde/stable/labplot/labplot-${version}.tar.xz";
    sha256 = "sha256-K24YFRfPtuDf/3uJXz6yDHzjWeZzLThUXgdXya6i2u8=";
  };

  cmakeFlags = [
    # Disable Vector BLF since it depends on DBC parser which fails to be detected
    "-DENABLE_VECTOR_BLF=OFF"
  ];

  patches = [
    (fetchpatch {
      name = "matio-fix-compilation-for-latest-version-1.5.27.patch";
      url = "https://github.com/KDE/labplot/commit/d6142308ffa492d9f7cea00fad3b4cd1babfd00c.patch";
      hash = "sha256-qD5jj6GxBKbQezKJb1Z8HnwFO84WJBGQDawS/6o/wHE=";
    })
  ];

  nativeBuildInputs = [
    cmake
    extra-cmake-modules
    shared-mime-info
    wrapQtAppsHook
  ];

  buildInputs = [
    qtbase

    karchive
    kcompletion
    kconfig
    kcoreaddons
    kcrash
    kdoctools
    ki18n
    kiconthemes
    kio
    knewstuff
    kparts
    ktextwidgets
    kxmlgui

    syntax-highlighting
    gsl

    poppler
    fftw
    hdf5
    netcdf
    cfitsio
    libcerf
    cantor
    zlib
    lz4
    readstat
    matio
    qtserialport
    discount
  ];

  meta = with lib; {
    description = "Free, open source and cross-platform data visualization and analysis software accessible to everyone";
    homepage = "https://labplot.kde.org";
    license = with licenses; [
      asl20
      bsd3
      cc-by-30
      cc0
      gpl2Only
      gpl2Plus
      gpl3Only
      gpl3Plus
      lgpl3Plus
      mit
    ];
    maintainers = with maintainers; [ hqurve ];
    mainProgram = "labplot2";
    platforms = platforms.unix;
  };
}
