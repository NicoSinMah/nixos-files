{ pkgs, config, ... }: {
  users.users.vaz = {
    isNormalUser = true;
    description = "ヴァイオレット・エヴァーガーデン";
    extraGroups = [ "networkmanager" "wheel" "docker" "adbusers" ];
    packages = [
      pkgs.home-manager
    ];
  };

  users.extraGroups.vboxusers.members = [ "user-with-access-to-virtualbox" ];

  home-manager.users.vaz = import ../../../../../home/gleipnir/${config.networking.hostName}.nix;
}
