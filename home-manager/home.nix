{ lib, pkgs, config, ... }:
let
	username = "rihardsza";
in {
  home = {
    inherit username;
    packages = with pkgs; [ hello ];   

    homeDirectory = "/home/${username}";

    stateVersion = "24.05";
    file = {
    ".config/nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink /home/rihardsza/dotfiles/nvim/.config/nvim;
    };
    };
  };
  programs.neovim = {
	  enable = true;
	  defaultEditor = true;
	  vimAlias = true;
	  viAlias = true;
  };
    programs.zsh = {
	    enable = true;
	    enableCompletion = true;
	    syntaxHighlighting.enable = true;
	    shellAliases = {
		    update = "sudo nixos-rebuild switch";
	    };
	    oh-my-zsh = {
	    	enable = true;
		plugins = [ "git" ];
		theme = "robbyrussell";
	    };
    };
}
