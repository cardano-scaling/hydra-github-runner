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
                  host = "ec2-15-188-52-33.eu-west-3.compute.amazonaws.com";
                  sshUser = "root";
                  buildOn = "remote";
                  substituteOnTarget = true;
                  hermetic = false;
                };
              }
              inputs.agenix.nixosModules.default
              (import ./modules/github-runner.nix)
              ({pkgs, ...}: {
                imports = [ "${inputs.nixpkgs}/nixos/modules/virtualisation/amazon-image.nix" ];

                nix.settings.trusted-users = [ "root" ];

                nix = {
                  package = pkgs.nixVersions.latest;
                  extraOptions = ''
                    experimental-features = nix-command flakes
                  '';
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
