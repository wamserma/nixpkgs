{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "zfind";
  version = "0.4.6";

  src = fetchFromGitHub {
    owner = "laktak";
    repo = "zfind";
    rev = "v${version}";
    hash = "sha256-bbeS2x9HzrsOE5h1y07LoEBm9dinMCHX9GJftj5Md9s=";
  };

  vendorHash = "sha256-blq0/pRppdf2jcuhIqYeNhcazFNZOGeEjPTSLgHqhrU=";

  ldflags = [
    "-X"
    "main.appVersion=${version}"
  ];

  meta = {
    description = "CLI for file search with SQL like syntax.";
    longDescription = ''
      zfind allows you to search for files, including inside tar, zip, 7z and rar archives.
      It makes finding files easy with a filter syntax that is similar to an SQL-WHERE clause.
    '';
    homepage = "https://github.com/laktak/zfind";
    changelog = "https://github.com/laktak/zfind/releases/tag/v${version}";
    license = lib.licenses.mit;
    mainProgram = "zfind";
    maintainers = with lib.maintainers; [ eeedean ];
  };
}
