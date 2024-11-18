{config, lib, ...}:
{
  xdg.configFile."starship.toml".source = ./starship.toml;
  xdg.configFile."starship-warp.toml".source = ./starship-warp.toml;
  programs.starship = {
    enable = true;
    # manually run fish integration
    enableFishIntegration = false;
  };
}
