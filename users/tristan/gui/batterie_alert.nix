{pkgs, ...}: {
  home.packages = [pkgs.acpi];
}
# TODO : add un cron ou un systemd.timer qui joue le script "batterie_alert.sh"

