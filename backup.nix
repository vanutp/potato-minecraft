{
  pkgs,
  lib,
  ...
}: {
  systemd.user.services.backup-hse-modded = {
    Service.ExecStart = lib.getExe (
      pkgs.writeShellApplication {
        name = "backup-hse-modded";

        runtimeInputs = with pkgs; [
          coreutils
          rdiff-backup
        ];

        text = ''
          mkdir -p ~/backup
          rdiff-backup backup \
            ~/hse-modded ~/backup
          rdiff-backup --force remove increments \
            --older-than 7D ~/backup || true
        '';
      }
    );
  };

  systemd.user.timers.backup-hse-modded = {
    Timer = {
      OnCalendar = "*-*-* *:00:00";
      Unit = "backup-hse-modded.service";
    };
    Install.WantedBy = ["default.target"];
  };
}
