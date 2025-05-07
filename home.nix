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
}