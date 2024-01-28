{ pkgs, lib, config, ... }:
let
in {
  imports = [
    ./banner.nix
  ];
  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.utf8";

  # network
  networking.firewall.allowedTCPPorts = [ 22 ];

  # security
  services = {
    # Not working yubikey with pgp when enabled
    #pcscd.enable = true;

    udev.packages = with pkgs; [
      yubikey-personalization
    ];

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
    };

    openssh = {
      enable = true;
      extraConfig = ''StreamLocalBindUnlink yes'';
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
      authorizedKeysFiles = [ "../yubikey.pub" ];
    };

    kmscon = {
      enable = true;
      extraOptions = "--xkb-layout ${config.services.xserver.layout}";
    };

    #gnome.gnome-keyring.enable = lib.mkForce false;
  };

  environment.shellInit = ''
    gpg-connect-agent /bye
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
  '';

  security = {
    pam.yubico = {
      enable = true;
      mode = "challenge-response";
      control = "sufficient";
      id = [ "22928767" ];
    };
    rtkit.enable = true;
  };

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
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJYHv/LMo8N6iM3zFvOKrF7ZLp3eAG/cOED0yDzrvgkd openpgp:0x74CCE9B8" ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  sound = {
    enable = true;
    mediaKeys.enable = true;
  };

  hardware = {
    pulseaudio.enable = false;
  };

  boot.plymouth.enable = true;

  programs = {
    nix-index-database.comma.enable = true;
    command-not-found.enable = false;
    fzf.keybindings = true;
    git = {
      enable = true;
      lfs.enable = true;
      config = {
        alias = {
          p = "pull";
          r = "reset --hard";
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
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    ssh.startAgent = false;
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
        flake = "nvim flake.nix";
        garbage = "sudo nix-collect-garbage -d";
        gpw = "git pull | grep \"Already up-to-date\" > /dev/null; while [ $? -gt 1 ]; do sleep 5; git pull | grep \"Already up-to-date\" > /dev/null; done; notify-send Pull f$";
        l = "ls -lah";
        nixdir = "echo \"use flake\" > .envrc && direnv allow";
        nixeditc = "nvim ~/dotfiles/system/configuration.nix";
        nixeditpc = "nvim ~/dotfiles/system/program.nix";
        pypi = "pip install --user";
        qr = "qrencode -m 2 -t utf8 <<< \"$1\"";
        update = "sudo nixos-rebuild switch --fast --flake ~/dotfiles/ -L";
        v = "nvim";
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
      withPython3 = true;
      configure = {
        customRC = ''
                    set undofile         " save undo file after quit
          	  set undolevels=1000  " number of steps to save
          	  set undoreload=10000 " number of lines to save

          	  " Save Cursor Position
          	  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
          	'';
        packages.myVimPackage = with pkgs.vimPlugins; {
          start = [
            colorizer
            copilot-vim
            csv-vim
            fugitive
            fzf-vim
            nerdtree
            nvchad
            nvchad-ui
            nvim-treesitter-refactor
            nvim-treesitter.withAllGrammars
            unicode-vim
            vim-cpp-enhanced-highlight
            vim-tmux
            vim-tmux-navigator
          ];
        };
      };
    };

    tmux = {
      enable = true;
      keyMode = "vi";
      terminal = "screen-256color\"\nset -g mouse on\n# \"";
      shortcut = "Space";
      baseIndex = 1;
      clock24 = true;
      plugins = with pkgs.tmuxPlugins; [
        nord
        vim-tmux-navigator
        sensible
        yank
      ];
    };

    #nix-index = {
    #  enable = true;
    #  #enableZshIntegration = true;
    #};

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        acl
        attr
        bzip2
        curl
        glib
        libglvnd
        libmysqlclient
        libsodium
        libssh
        libxml2
        openssl
        stdenv.cc.cc
        systemd
        util-linux
        xz
        zlib
        zstd
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
    "electron-19.1.9"
  ];

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      keep-outputs = true;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
    gedit
  ]) ++ (with pkgs.gnome; [
    cheese # webcam tool
    gnome-contacts
    gnome-music
    gnome-weather
    gnome-maps
    gnome-terminal
    simple-scan # document scanner
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
