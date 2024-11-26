{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:

buildGoModule {
  pname = "snackdaemon";
  version = "unstable-2024-07-18";

  src = fetchFromGitHub {
    owner = "Shiphan";
    repo = "snackdaemon";
    rev = "14867c2853b1284d45ac4caa20e75f370074cd77";
    hash = "sha256-IZ8UvdFYN6VZG099BfDxbqI+Ay/VmtyqLZfUAysUAUM=";
  };

  vendorHash = null;

  ldflags = [ "-s" "-w" ];

  meta = {
    description = "Daemon for snackbar";
    homepage = "https://github.com/Shiphan/snackdaemon";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ shiphan ];
    mainProgram = "snackdaemon";
  };
}
