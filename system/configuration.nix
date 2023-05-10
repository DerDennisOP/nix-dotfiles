{ pkgs, ... }:
{
  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  # enable Font folder
  fonts.fontDir.enable = true;

  # Configure console keymap
  console.keyMap = "de";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.dennis = {
    isNormalUser = true;
    description = "Dennis Wuitz";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # Allow broken packages
  nixpkgs.config.allowBroken = true;
  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  programs = {
    command-not-found.enable = true;
    #fzf.keybindings = true;
    git = {
      enable = true;
      config = {
        alias = {
          ci = "commit";
          co = "checkout";
          lg = "log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)'";
          st = "status";
          undo = "reset --soft HEAD^";
        };
        interactive.singlekey = true;
        pull.rebase = true;
        rebase.autoStash = true;
        safe.directory = "/etc/nixos";
      };
    };
    zsh = {
      enable = true;
      autosuggestions = {
        enable = true;
        strategy = [ "completion" ];
        async = true;
      };
      syntaxHighlighting.enable = true;
      zsh-autoenv.enable = true;
      enableCompletion = true;
      enableBashCompletion = true;
      ohMyZsh = {
        enable = true;
        plugins = [ "git" "sudo" "docker" "kubectl" "history" "colorize" "direnv" ];
        theme = "agnoster";
      };
      shellAliases = {
	gpw = "git pull | grep \"Already up-to-date\" > /dev/null; while [ $? -gt 1 ]; do sleep 5; git pull | grep \"Already up-to-date\" > /dev/null; done; notify-send Pull f$";
        garbage = "sudo nix-collect-garbage -d";
        l = "ls -l -a";
        nixdir = "echo \"use flake\" > .envrc && direnv allow";
        nixeditc = "nvim ~/dotfiles/system/configuration.nix";
        nixeditpc = "nvim ~/dotfiles/system/program.nix";
        pypi = "pip install --user";
        update = "sudo nixos-rebuild switch --fast --flake ~/dotfiles/ -L";
        v = "nvim";
        vim = "nvim";
      };
      promptInit = ''
        command_not_found_handler() {
	  local command="$1"
	  local parameters=("$\{(@)argv[2, -1]}")
	  comma "$command" "$parameters"
	}
      '';
    };

    neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      viAlias = true;
      configure = {
        packages.myVimPackage = with pkgs.vimPlugins; {
	  start = [ fugitive nvim-treesitter.withAllGrammars nvim-treesitter-refactor vim-cpp-enhanced-highlight colorizer ];
	};
      };
    };

    #nix-index = {
    #  enable = true;
    #  #enableZshIntegration = true;
    #};

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        linuxKernel.packages.linux_6_2.nvidia_x11
        zlib
        zstd
        stdenv.cc.cc
        curl
        openssl
        attr
        libssh
        bzip2
        libxml2
	libmysqlclient
        acl
        libsodium
        util-linux
        xz
        systemd
        glib
        libglvnd
      ];
    };
  };

  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "de_DE.UTF-8/UTF-8"
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "adobe-reader-9.5.5"
    "electron-12.2.3"
    "electron-14.2.9"
  ];

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-oder-than 14d";
    };
  };

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-music
    gnome-terminal
    gedit # text editor
    epiphany # web browser
    geary # email reader
    evince # document viewer
    gnome-characters
    totem # video player
    tali # poker game
    iagno # go game
    hitori # sudoku game
    atomix # puzzle game
  ]);

  system.stateVersion = "22.11";
}
