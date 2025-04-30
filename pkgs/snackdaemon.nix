{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule rec {
  pname = "snackdaemon";
  version = "0.4.0";

  src = fetchFromGitHub {
    owner = "Shiphan";
    repo = "snackdaemon";
    rev = "v${version}";
    hash = "sha256-pvmaHlnceTOBC6POE9Zm6ZXUUIUo5Zp/WhMc6UBevvI=";
  };

  vendorHash = null;

  ldflags = [
    "-s"
    "-w"
  ];

  meta = {
    description = "Daemon for snackbar";
    homepage = "https://github.com/Shiphan/snackdaemon";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ shiphan ];
    mainProgram = "snackdaemon";
  };
}
