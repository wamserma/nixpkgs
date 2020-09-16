{ stdenv, fetchurl, jre, runtimeShell }:
let
  pname = "junixsocket";
  version = "2.3.2";
  src = fetchurl {
    url = "https://github.com/kohlschutter/junixsocket/releases/download/${pname}-parent-${version}/${pname}-dist-${version}-bin.tar.gz";
    sha256 = "0fp0xaxky0hxrcn7zznpgh1xzmy7jsnbaj55s9adxjb8gj6mia0a";
  };
  selftestjar = "${pname}-selftest-${version}-jar-with-dependencies.jar";
in
stdenv.mkDerivation {
  inherit pname;
  inherit version;
  inherit src;

  preferLocalBuild = true;
  outputs = [ "lib" "test" "out" ];

  dontConfigure = true;
  dontBuild = true;

  installPhase =
    ''
      mkdir -p $lib/share/java
      cp lib/*.jar $lib/share/java/.
      mkdir -p $test
      cp ${selftestjar} $test/.
    '';

  doCheck = true;
  checkInputs = [ jre ];
  checkPhase = ''
      #!${runtimeShell}
      ${jre}/bin/java -jar ${selftestjar} "$@" | tee test.log
      grep -F 'Selftest PASSED' test.log
    '';

  meta = {
    description = "A Java/JNI library for using Unix Domain Sockets from Java";
    homepage = "https://github.com/kohlschutter/junixsocket";
    license = stdenv.lib.licenses.asl20;
    platforms = stdenv.lib.platforms.linux;
  };
}
