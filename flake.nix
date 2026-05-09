{
  description = "Radarr distroless image";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: let
    system = builtins.currentSystem;
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages.${system} = {
      radarr-image = pkgs.dockerTools.buildLayeredImage {
        name = "radarr";
        tag = "latest";
        contents = [ 
          pkgs.radarr
          pkgs.cacert
          pkgs.tzdata
        ];
        config = {
          Env = [
            "COMPlus_EnableDiagnostics=0"
            "TMPDIR=/run/radarr-temp"
          ];
          ExposedPorts = {
            "7878/tcp" = {};
          };
          Volumes = {
            "/config" = {};
            "/data" = {};
          };
          # Tell radarr to use /config as its data directory
          Cmd = [ "${pkgs.radarr}/bin/Radarr" "-data=/config" "-nobrowser" ];

        };
      };
    };

    # Expose the radarr version for CI workflows
    radarrVersion = pkgs.radarr.version;

    defaultPackage.${system} = self.packages.${system}.radarr-image;
  };
}
