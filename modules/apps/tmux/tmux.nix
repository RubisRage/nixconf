{ config, pkgs, ... }:

let
    catppuccin-tmux = pkgs.tmuxPlugins.mkTmuxPlugin {
        pluginName = "catppuccin";
        version = "b4e0715356f820fc72ea8e8baf34f0f60e891718";
        src = pkgs.fetchFromGitHub {
            owner = "dreamsofcode-io";
            repo = "catppuccin-tmux";
            rev = "b4e0715356f820fc72ea8e8baf34f0f60e891718";
            sha256 = "sha256-FJHM6LJkiAwxaLd5pnAoF3a7AE1ZqHWoCpUJE0ncCA8=";
        };
    };
in
{
  programs.tmux = {
  	enable = true;
  	shell = "${pkgs.zsh}/bin/zsh";
  	escapeTime = 0;
  	mouse = true;

	plugins =  let 
	in with pkgs.tmuxPlugins; 
	[
		yank
		sensible
		catppuccin-tmux
	];

	extraConfig = ( builtins.readFile ./tmux.conf );

  };
}
