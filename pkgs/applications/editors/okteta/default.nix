{
  mkDerivation,
  lib,
  fetchurl,
  extra-cmake-modules,
  kdoctools,
  qtscript,
  kconfig,
  kinit,
  karchive,
  kcrash,
  kcmutils,
  kconfigwidgets,
  knewstuff,
  kparts,
  qca-qt5,
  shared-mime-info,
}:

mkDerivation rec {
  pname = "okteta";
  version = "0.26.22";

  src = fetchurl {
    url = "mirror://kde/stable/okteta/${version}/src/${pname}-${version}.tar.xz";
    sha256 = "sha256-vi7XhMj/PaMeK4V6FxU7Yi7XyWMaOBUenafZPpaP+n0=";
  };

  nativeBuildInputs = [
    qtscript
    extra-cmake-modules
    kdoctools
  ];
  buildInputs = [ shared-mime-info ];

  propagatedBuildInputs = [
    kconfig
    kinit
    kcmutils
    kconfigwidgets
    knewstuff
    kparts
    qca-qt5
    karchive
    kcrash
  ];

  outputs = [
    "out"
    "dev"
  ];

  meta = with lib; {
    license = licenses.gpl2;
    description = "Hex editor";
    homepage = "https://apps.kde.org/okteta/";
    maintainers = with maintainers; [
      peterhoeg
      bkchr
    ];
    platforms = platforms.linux;
  };
}
