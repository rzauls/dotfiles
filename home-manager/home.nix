{ lib, pkgs, ... }:
let
	username = "rihardsza";
in {
  home = {
    inherit username;
    packages = with pkgs; [ hello ];   

    homeDirectory = "/home/${username}";

    stateVersion = "24.05";
    file = {
    	"hello.txt" = {
	  text = ''
	  #!/usr/bin/env bash

	  echo "hello, ${username} from nixos flake"
	  '';
	  executable = true;
	};
    };
  };
  programs.neovim = {
  enable = true;
  defaultEditor = true;
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
