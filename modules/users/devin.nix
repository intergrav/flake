{pkgs, ...}: let
  isDarwin = pkgs.stdenv.isDarwin;
  homeDir =
    if isDarwin
    then "/Users/devin"
    else "/home/devin";
in {
  users.users.devin =
    {
      home = homeDir;
      shell = pkgs.fish;
    }
    // (
      if isDarwin
      then {uid = 501;}
      else {
        isNormalUser = true;
        extraGroups = ["networkmanager" "wheel"];
      }
    );

  home-manager.users.devin = {pkgs, ...}: {
    home = {
      username = "devin";
      homeDirectory = homeDir;
      stateVersion = "23.11";
      packages = with pkgs; [
        alejandra
        bat
        bun
        coreutils
        fastfetch
        fd
        fzf
        gh
        git
        grc
        just
        lazygit
        nh
        nix-your-shell
        nixd
        packwiz
        rsync
        starship
        xz
      ];
    };

    programs = {
      home-manager.enable = true;

      fastfetch = {
        enable = true;
        settings = {
          logo = {
            type = "small";
          };
          modules = [
            "title"
            "uptime"
            "host"
            "os"
            "localip"
            "disk"
            "media"
          ];
        };
      };

      fish = {
        enable = true;
        interactiveShellInit = ''
          if test "$TERM" = "xterm-ghostty"
            set -x TERM xterm-256color
          end
          if command -q nix-your-shell
            nix-your-shell fish | source
          end
          starship init fish | source
          fish_add_path /opt/homebrew/bin
          fastfetch
          set fish_greeting
        '';
        plugins = [
          {
            name = "fzf-fish";
            src = pkgs.fishPlugins.fzf-fish.src;
          }
          {
            name = "grc";
            src = pkgs.fishPlugins.grc.src;
          }
        ];
      };

      git = {
        enable = true;
        settings = {
          user.name = "intergrav";
          user.email = "devin@devins.page";
          credential.helper = "!gh auth git-credential";
          pull.rebase = true;
          rebase.autoStash = true;
        };
      };

      neovim = {
        enable = true;
        extraLuaConfig = ''
          vim.opt.termguicolors = false
        '';
      };

      tmux = {
        enable = true;
        plugins = with pkgs.tmuxPlugins; [sensible];
      };
    };
  };
}
