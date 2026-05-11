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
    version = "6.1.1.10360";
    srcHash = "sha256-AtvuZFAF+KJmEp46KWrA9qHv3+IejSXxUyol2W8BWdk=";
    pkg = pkgs.radarr.overrideAttrs (old: {
      inherit version;
      src = pkgs.fetchFromGitHub {
        owner = "Radarr";
        repo = "Radarr";
        rev = "v${version}";
        hash = srcHash;
      };
      nugetDeps = if builtins.pathExists ./deps.json then map (dep: pkgs.fetchNuGet dep) (builtins.fromJSON (builtins.readFile ./deps.json)) else pkgs.radarr.nugetDeps;
      dotnetBuildFlags = [ "--maxcpucount:1" ];
    });
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
      Cmd = [ "${pkg}/bin/Radarr" "-data=/config" "-nobrowser" ];
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

      radarr = pkg;

      default = self.packages.${system}.radarr-image;
    };

    radarrVersion = version;
  };
}
