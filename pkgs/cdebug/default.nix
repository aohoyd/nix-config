{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "cdebug";
  version = "0.0.17";

  src = fetchFromGitHub {
    owner = "iximiuz";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-lEdfDEpN7/AWUxP28aK1lCC3h1izhqHx971jLUx4HM4=";
  };

  vendorHash = "sha256-t5ukROp4sR/wiRTGGGUOYzGO9ctsMTq/fA8CfV6zQdU=";

  ldflags = [
    "-X main.version=v${version}"
    "-X main.commit=${version}"
  ];

  CGO_ENABLED = 0;

  # integration tests require network and kubernetes master
  doCheck = false;

  meta = with lib; {
    homepage = "https://github.com/iximiuz/${pname}";
    changelog = "https://github.com/iximiuz/${pname}/releases/tag/v${version}";
    description = "A swiss army knife of container debugging";
    license = licenses.asl20;
    maintainers = with maintainers; [ urandom ];
  };
}
