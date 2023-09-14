{config, lib, ...}:
{
  home.file.viddy = {
    target = "Library/Application Support/viddy.toml";
    text = ''
      [color]
      text = "white"
    '';
  };
}
