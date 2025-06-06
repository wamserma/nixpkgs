{
  lib,
  python3,
  fetchFromGitHub,
}:

python3.pkgs.buildPythonApplication rec {
  pname = "loramon";
  version = "0.9.7";
  pyproject = true;

  src = fetchFromGitHub {
    owner = "markqvist";
    repo = "LoRaMon";
    tag = version;
    hash = "sha256-94tXhuAoaS1y/zGz63PPqOayRylGK0Ei2a6H4/BCB30";
  };

  nativeBuildInputs = with python3.pkgs; [
    setuptools
  ];

  propagatedBuildInputs = with python3.pkgs; [
    pyserial
  ];

  meta = {
    description = "LoRa packet sniffer for RNode hardware";
    mainProgram = "loramon";
    homepage = "https://github.com/markqvist/LoRaMon";
    changelog = "https://github.com/markqvist/LoRaMon/releases/tag/${version}";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ erethon ];
  };
}
