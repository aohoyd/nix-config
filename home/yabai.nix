{config, lib, ...}:
{
  home.file.yabai = {
    executable = true;
    target = ".config/yabai/yabairc";
    text = ''
      #!/usr/bin/env sh

      # Mouse config

      # center mouse on window with focus
      yabai -m config mouse_follows_focus off
      yabai -m config focus_follows_mouse off

      # modifier for clicking and dragging with mouse
      yabai -m config mouse_modifier alt
      # set modifier + left-click drag to move window
      yabai -m config mouse_action1 move
      # set modifier + right-click drag to resize window
      yabai -m config mouse_action2 resize


      # when window is dropped in center of another window, swap them (on edges it will split it)
      yabai -m mouse_drop_action swap

      # Window config
      yabai -m config window_placement first_child

      # layout
      yabai -m config auto_balance off
      yabai -m config window_topmost on
      yabai -m config layout bsp

      # gaps
      yabai -m config top_padding    0
      yabai -m config bottom_padding 0
      yabai -m config left_padding   0
      yabai -m config right_padding  0
      yabai -m config window_gap     0

      # rules
      yabai -m rule --add app="^System Settings$" manage=off
      yabai -m rule --add app="^Dash$" manage=off
      yabai -m rule --add app="^Толк$" manage=off
      yabai -m rule --add app="^OpenVPN Connect$" manage=off
      yabai -m rule --add app="^Tunnelblick$" manage=off
      yabai -m rule --add app="^Raycast$" manage=off

      # workspace management
      yabai -m space 1 --label www
      yabai -m space 2 --label code
      yabai -m space 3 --label ide
      yabai -m space 4 --label chat
      yabai -m space 5 --label mail
      yabai -m space 6 --label todo
      yabai -m space 7 --label split

      yabai -m config --space 2 layout stack
      yabai -m config --space 3 layout stack

      # assign apps to spaces
      # yabai -m rule --add app="Arc" space=www

      yabai -m rule --add app="Code" space=code
      yabai -m rule --add app="Sublime" space=code
      yabai -m rule --add app="Zed" space=code

      yabai -m rule --add app="PyCharm" space=ide
      yabai -m rule --add app="GoLand" space=ide
      yabai -m rule --add app="Lens" space=ide

      yabai -m rule --add app="Telegram" space=chat
      yabai -m rule --add app="Mattermost" space=chat

      yabai -m rule --add app="UpNote" space=todo
      yabai -m rule --add app="Bear" space=todo
      yabai -m rule --add app="Anytype" space=todo

      echo "yabai configuration loaded.."
    '';
  };
}
