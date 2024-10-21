{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage {
  pname = "wdi";
  version = "unstable-2024-09-12";

  src = fetchFromGitHub {
    owner = "Shiphan";
    repo = "wdi";
    rev = "30055e5cefbcf495e54650f4cac5617cb14a4a99";
    hash = "sha256-pt/AawfZIBSAlzohCRVsuHuO/3whKofJRwixw6qPnBA=";
  };

  cargoHash = "sha256-Y9ycEoQ1gQJ9xVZg+1eCfDO9wLOBbPq4/BHh9ssLU6I=";

  meta = {
    description = "Walk through Directory with Interface";
    homepage = "https://github.com/Shiphan/wdi";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ shiphan ];
    mainProgram = "wtdwi";
  };
}
