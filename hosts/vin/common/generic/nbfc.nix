{ pkgs, ... }:
let
  filename = "nbfc/nbfc.json";

  # Aquí puedes poner la config.json de tu laptop.
  # Debe existir en nbfc.
  nitroConfig = ''
    {"SelectedConfigId": "Acer Nitro AN515-44"}
  '';
in {
  environment.systemPackages = with pkgs; [
    nbfc-linux
  ];

  systemd.services.nbfc_service = {
    enable = true;
    description = "NoteBook FanControl service";
    serviceConfig.Type = "simple";

    # Necesario para cargar módulos si NBFC lo requiere
    path = [ pkgs.kmod ];

    # El servicio principal
    script = "${pkgs.nbfc-linux}/bin/nbfc_service --config-file '/etc/${filename}'";

    wantedBy = [ "multi-user.target" ];
  };

  # Instala el archivo /etc/nbfc/nbfc.json al sistema
  environment.etc."${filename}".text = nitroConfig;
}

