{
  pkgs,
  lib,
  ...
}: {
  systemd.user.services.backup-hse-modded = {
    Service = {
      Type = "oneshot";
      ExecStart = lib.getExe (
        pkgs.writeShellApplication {
          name = "backup-hse-modded";

          runtimeInputs = with pkgs; [
            coreutils
            rdiff-backup
          ];

          text = ''
            mkdir -p ~/backup
            rdiff-backup backup \
              ~/modded-hserver ~/backup
            rdiff-backup --force remove increments \
              --older-than 7D ~/backup || true
          '';
        }
      );
    };
  };

  systemd.user.timers.backup-hse-modded = {
    Timer = {
      OnCalendar = "*-*-* *:00:00";
    };
    Install.WantedBy = ["timers.target"];
  };
}
