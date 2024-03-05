{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "cdebug";
  version = "0.0.18";

  src = fetchFromGitHub {
    owner = "iximiuz";
    repo = pname;
    rev = "v${version}";
    hash = "sha256-WzIHP8FCwETDSJ3VJXUUY0asNUYhNMJbhKWggsijAhg=";
  };

  vendorHash = "sha256-NTU6/UUF1bDeXepayfPbLhmKUXFaMbO/GlCQulRI5sw=";

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
