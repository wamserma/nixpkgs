{ stdenv, fetchFromGitHub, meson, ninja, cmake
, wrapGAppsHook, pkgconfig, desktop-file-utils
, appstream-glib, python3Packages, glib, gobject-introspection, libhandy
, gst_all_1
, gtk3, webkitgtk, glib-networking, gnome3
, shared-mime-info}:

let
  pythonEnv = python3Packages.python.withPackages(p: with p;
    [ setuptools gst-python pygobject3 ]);

in stdenv.mkDerivation rec {
  pname = "blanket";
  version = "0.3.1";

  src = fetchFromGitHub {
    owner  = "rafaelmardojai";
    repo   = pname;
    rev    = "${version}";
    sha256 = "13xip9b2p2ai2jchkck71c849s2rlxzfvlbsgpraw9hswi0rk0jg";
  };

  nativeBuildInputs = [ meson ninja cmake pkgconfig desktop-file-utils
    appstream-glib wrapGAppsHook ];

  buildInputs = [ glib pythonEnv gobject-introspection gtk3 libhandy
    gnome3.adwaita-icon-theme webkitgtk glib-networking gst_all_1.gst-plugins-bad gst_all_1.gstreamer ];

  postPatch = ''
    patchShebangs --build build-aux/meson/postinstall.py
    substituteInPlace build-aux/meson/postinstall.py --replace "/usr/local" "$out"
    # drop the postinstall script as it has no effect for us
    substituteInPlace meson.build --replace "meson.add_install_script('build-aux/meson/postinstall.py')" ""
    substituteInPlace src/meson.build --replace "python.find_installation('python3').path()" "'${pythonEnv}/bin/python'"
  '';

  preFixup = ''
    gappsWrapperArgs+=(
      --prefix PYTHONPATH : "$out/lib/python${pythonEnv.pythonVersion}/site-packages/"
      --prefix XDG_DATA_DIRS : "${shared-mime-info}/share"
    )
  '';

  meta = with stdenv.lib; {
    homepage = "https://github.com/rafaelmardojai/blanket";
    description = "A distraction free Markdown editor for GNU/Linux";
    license = licenses.gpl3;
    platforms = platforms.linux;
    maintainers = [ maintainers.sternenseemann ];
  };
}
