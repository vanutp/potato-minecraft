{...}: {
  imports = [
    ./backup.nix
    ./shell
    ./packages.nix
  ];

  home.username = "minecraft";
  home.homeDirectory = "/home/minecraft";
  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
  xdg.enable = true;

  programs.git = {
    enable = true;
    lfs.enable = true;
  };
  programs.zsh.initExtra = ''
    export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock
  '';
}