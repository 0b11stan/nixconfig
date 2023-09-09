{pkgs, ...}: {
  home.packages = with pkgs; [grim slurp];
  home.shellAliases.screenshot = "grim -g \"$(slurp)\" /tmp/$(date +screenshot-%s.png)";
}
