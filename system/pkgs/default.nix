self: super: {
  exegol = super.callPackage ./exegol.nix {};
  wazuh-agent = super.callPackage ./wazuh-agent.nix {};
}
