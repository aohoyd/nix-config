{config, lib, ...}:
{
  xdg.configFile."starship.toml".source = ./starship.toml;
  programs.starship = {
    enable = true;
    # manually run fish integration
    enableFishIntegration = false;
  };
}
