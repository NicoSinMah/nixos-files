{ config, pkgs, ... }:
let
  rose-pine-fish = pkgs.fetchFromGitHub {
    owner = "rose-pine";
    repo = "fish";
    rev = "0749331afd4be6bc8035a812a20e489efe1d616f";
    hash = "sha256-hOcsGt0IMoX1a02t85qeoE381XEca0F2x0AtFNwOqj0=";
  };
in
{
  home.file = {
    ".config/fish/themes/Rosé Pine.theme".source = "${rose-pine-fish}/themes/Rosé Pine.theme";
  };
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "eza --color=always --git --icons=always --no-time --no-user --no-permissions -a";
      ll = "eza --color=always --long --git --icons=always -la";
      tree = "eza --tree";
      cat = "bat --theme Dracula";
      venv = "source venv/bin/activate.fish";
      ssh = "env TERM=xterm-256color ssh";
      dot = "git --git-dir=$HOME/dotfiles/ --work-tree=$HOME";
      v = "nvim";
    };
    plugins = [
      {
        name = "fish-ssh-agent";
        src = pkgs.fetchFromGitHub {
          owner = "danhper";
          repo = "fish-ssh-agent";
          rev = "f10d95775352931796fd17f54e6bf2f910163d1b";
          sha256 = "sha256-cFroQ7PSBZ5BhXzZEKTKHnEAuEu8W9rFrGZAb8vTgIE=";
        };
      }
    ];
    interactiveShellInit = ''
      set -U fish_greeting

      fish_config theme choose Rosé\ Pine
      fish_config prompt choose astronaut
      fish_hybrid_key_bindings

      function handle_directory_change --on-variable PWD
          git rev-parse 2>/dev/null
          if test $status -eq 0
            if not ssh-add -l | grep -q nicovalmu2003
              ssh-add ~/secrets/ssh/id_ed25519
            end
            onefetch -d dependencies authors contributors license -i /home/${config.home.username}/Downloads/fondogithub.jpeg --image-protocol kitty
          end
      end

      zoxide init --cmd cd fish | source
      source /home/${config.home.username}/.env

      if test -z "$TMUX"
        fastfetch
      end
    '';
  };
}
