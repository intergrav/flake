{
  lib,
  pkgs,
  ...
}: let
  homeDir =
    if pkgs.stdenv.isDarwin
    then "/Users/devin"
    else "/home/devin";
in {
  users.users.devin =
    {
      home = homeDir;
      shell = pkgs.fish;
    }
    // lib.optionalAttrs (!pkgs.stdenv.isDarwin) {
      isNormalUser = true;
      extraGroups = ["networkmanager" "wheel"];
    };

  home-manager.users.devin = {pkgs, ...}: {
    home = {
      username = "devin";
      homeDirectory = homeDir;
      stateVersion = "23.11";
      packages = with pkgs; [
        alejandra
        bun
        coreutils
        gh
        git
        just
        nixd
        packwiz
        rsync
        starship
        xz
      ];
    };

    programs = {
      home-manager.enable = true;

      fish = {
        enable = true;
        interactiveShellInit = ''
          if test "$TERM" = "xterm-ghostty"
            set -x TERM xterm-256color
          end
          starship init fish | source
          fish_add_path /opt/homebrew/bin
        '';
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
        plugins = with pkgs.vimPlugins; [
          lualine-nvim
          nvim-tree-lua
          nvim-treesitter
          nvim-treesitter-parsers.nix
          plenary-nvim
          telescope-nvim
          vim-commentary
        ];
        extraLuaConfig = ''
          vim.opt.termguicolors = false
          require('lualine').setup()
          require('nvim-tree').setup()
          require('telescope').setup()
          require('nvim-treesitter.configs').setup({highlight = {enable = true}})
          vim.g.mapleader = " "
          vim.keymap.set('n', '<leader>e', '<cmd>NvimTreeToggle<CR>')
          vim.keymap.set('n', '<leader>f', '<cmd>Telescope find_files<CR>')
          vim.keymap.set('n', '<leader>g', '<cmd>Telescope live_grep<CR>')
        '';
      };

      tmux = {
        enable = true;
        plugins = with pkgs.tmuxPlugins; [sensible];
      };
    };
  };
}
