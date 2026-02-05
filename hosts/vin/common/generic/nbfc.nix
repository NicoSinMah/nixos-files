{
  pkgs, ...
}:

{
  environment.systemPackages = with pkgs; [
    nbfc-linux
  ];

  systemd.services.nbfc_service = {
    enable = true;
    description = "NoteBook FanControl service";
    serviceConfig.Type = "simple";

    path = [ pkgs.kmod ];

    script = "${pkgs.nbfc-linux}/bin/nbfc_service --config-file '/etc/nbfc/nbfc.json'";
    wantedBy = [ "multi-user.target" ];
  };

  # Instala tu JSON COMPLETO al sistema
  environment.etc."nbfc/nbfc.json".source =
    ./nitro-an515-44.json;
}

