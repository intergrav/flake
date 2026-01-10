{pkgs, ...}: {
  home.packages = with pkgs; [
    ripgrep
  ];

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      nvim-lspconfig

      nvim-treesitter
      nvim-treesitter.withAllGrammars

      telescope-nvim
      plenary-nvim
      telescope-fzf-native-nvim

      nvim-cmp
      luasnip
      cmp_luasnip

      nvim-tree-lua

      lazygit-nvim

      transparent-nvim
    ];
    extraLuaConfig = ''
      vim.g.loaded_netrw = 1
      vim.g.loaded_netrwPlugin = 1
      vim.opt.cmdheight = 0
      require("nvim-tree").setup()
      require('transparent').setup({})
    '';
  };
}
