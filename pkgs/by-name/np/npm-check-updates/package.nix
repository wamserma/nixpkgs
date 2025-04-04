{ lib
, buildNpmPackage
, fetchFromGitHub
}:

buildNpmPackage rec {
  pname = "npm-check-updates";
  version = "17.1.16";

  src = fetchFromGitHub {
    owner = "raineorshine";
    repo = "npm-check-updates";
    rev = "refs/tags/v${version}";
    hash = "sha256-yNo1W+Twzs3jG9bZzgjDLTxvZYCXY/FhoGtjlh6ZMZo=";
  };

  npmDepsHash = "sha256-8jxuKxL7PEGYqK6kwSPnfmoQH4RLmL8sGi989RDBBSI=";

  postPatch = ''
    sed -i '/"prepare"/d' package.json
  '';

  makeCacheWritable = true;

  meta = {
    changelog = "https://github.com/raineorshine/npm-check-updates/blob/${src.rev}/CHANGELOG.md";
    description = "Find newer versions of package dependencies than what your package.json allows";
    homepage = "https://github.com/raineorshine/npm-check-updates";
    license = lib.licenses.asl20;
    mainProgram = "ncu";
    maintainers = with lib.maintainers; [ flosse ];
  };
}
