{pkgs, ...}: let
  active = builtins.readDir /sys/class/power_supply == {};
in
  if active
  then {
    home.packages = [pkgs.acpi];
  }
  else {}
# TODO : add un cron ou un systemd.timer qui joue le script "batterie_alert.sh"

