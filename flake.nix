{
  description = "Radarr distroless image using nix2container";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nix2container.url = "github:nlewo/nix2container";
    base.url = "github:podmania/base";
  };

  outputs = { self, nixpkgs, nix2container, base }: let
    system = builtins.currentSystem;
    pkgs = nixpkgs.legacyPackages.${system};
    n2c = nix2container.outputs.packages.${system}.nix2container;
    imageConfig = {
      Env = [
        "COMPlus_EnableDiagnostics=0"
        "TMPDIR=/run/radarr-temp"
        "RADARR__UPDATE__MECHANISM=Docker"
      ];
      ExposedPorts = {
        "7878/tcp" = {};
      };
      Volumes = {
        "/config" = {};
        "/data" = {};
      };
      Cmd = [ "${pkgs.radarr}/bin/Radarr" "-data=/config" "-nobrowser" ];
    };
  in {
    packages.${system} = {
      radarr-image = n2c.buildImage {
        name = "radarr";
        tag = "latest";
        fromImage = base.packages.${system}.base-image;
        config = imageConfig;
      };

      radarr-debug-image = n2c.buildImage {
        name = "radarr";
        tag = "latest-debug";
        fromImage = base.packages.${system}.base-debug-image;
        config = imageConfig;
      };

      radarr = pkgs.radarr;

      default = self.packages.${system}.radarr-image;
    };

    radarrVersion = pkgs.radarr.version;
  };
}
