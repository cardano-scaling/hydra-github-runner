{
  description = "hydra-github-runner";

  inputs = {
    agenix.url = "github:ryantm/agenix";
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixinate.url = "github:MatthewCroughan/nixinate";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      flake = {
        apps = inputs.nixinate.nixinate."x86_64-linux" inputs.self;

        nixosConfigurations = {
          parasol = inputs.nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = inputs;
            modules = [
              {
                _module.args.nixinate = {
                  host = "ec2-35-180-21-160.eu-west-3.compute.amazonaws.com";
                  sshUser = "root";
                  buildOn = "remote";
                  substituteOnTarget = true;
                  hermetic = false;
                };
              }
              inputs.agenix.nixosModules.default
              (import ./modules/github-runner.nix)
              ({ pkgs, ... }: {
                imports = [ "${inputs.nixpkgs}/nixos/modules/virtualisation/amazon-image.nix" ];

                nix = {
                  package = pkgs.nixVersions.latest;
                  extraOptions = ''
                    experimental-features = nix-command flakes
                    accept-flake-config = true
                  '';
                  settings.trusted-users = [ "root" ];
                  settings.substituters = [
                    "https://cache.iog.io"
                    "https://hydra-node.cachix.org"
                    "https://cardano-scaling.cachix.org"
                  ];
                  settings.trusted-public-keys = [
                    "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
                    "hydra-node.cachix.org-1:vK4mOEQDQKl9FTbq76NjOuNaRD4pZLxi1yri31HHmIw="
                    "cardano-scaling.cachix.org-1:RKvHKhGs/b6CBDqzKbDk0Rv6sod2kPSXLwPzcUQg9lY="
                  ];
                };
                services.openssh.enable = true;

                system.stateVersion = "24.05";

              })
            ];
          };
        };
      };

      perSystem = { pkgs, system, ... }:
        { };
    };
}
