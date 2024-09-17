{ config, pkgs, lib, ... }: {

  age.secrets."hydra.tokenFile".file = ../secrets/hydra.tokenFile.age;

  services.github-runners =

    lib.genAttrs
    (builtins.genList (n: "parasol-${toString (n + 1)}") 3)
    (name: {
      inherit name;
      enable = true;
      url = "https://github.com/cardano-scaling/hydra";
      tokenFile = config.age.secrets."hydra.tokenFile".path;
      extraLabels = [ "nixos" ];
      replace = true;
    });
}
