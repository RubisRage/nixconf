{ config, pkgs, fetchFromGitHub, ... }:

let
	username = "rubisrage";
	homeDir = "/home/${username}";
in
{
  home.username = username;
  home.homeDirectory = homeDir;
  home.stateVersion = "23.11"; # Dont change

  home.packages = with pkgs; [
    # Essentials
    git
    gcc

    # Terminal
    tmux

    # Fonts
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];

  imports =
    [ 
        ../../modules/apps/tmux/tmux.nix
    ];

  programs.git = {
      enable = true;
      userName = "Rubén Santana Lorenzo";
      userEmail = "rubensanlor@gmail.com";
  };

  # programs.home-manager.enable = true;
  programs.zsh = {
      enable = true;
      sessionVariables = {
          EDITOR = "nvim";
      };
  };

  programs.neovim = {
  	enable = true;
  	vimAlias = true;
  	viAlias = true;
	plugins = [ pkgs.vimPlugins.packer-nvim ];
  };

  home.file.".config/nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/dotfiles/nvim";
    recursive = true;
  };

}
