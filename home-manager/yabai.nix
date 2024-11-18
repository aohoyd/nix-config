{config, lib, ...}:
{
  home.file.yabai = {
    executable = true;
    target = ".config/yabai/yabairc";
    text = ''
      #!/usr/bin/env sh

      # Mouse config

      # center mouse on window with focus
      yabai -m config mouse_follows_focus on
      yabai -m config focus_follows_mouse autofocus

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
      yabai -m rule --add app="^OpenVPN Connect$" manage=off
      yabai -m rule --add app="^Tunnelblick$" manage=off
      yabai -m rule --add app="^Raycast$" manage=off

      # workspace management
      yabai -m display 1 --label right
      yabai -m display 2 --label left
      yabai -m display 3 --label main

      yabai -m space 1 --label code
      yabai -m space 2 --label todo
      yabai -m space 3 --label www
      yabai -m space 4 --label chat
      yabai -m space 5 --label mail
      yabai -m space 6 --label terminal

      yabai -m config --space code layout stack

      # assign apps to spaces

      ######################## Display main ########################
      yabai -m rule --add app="kitty" space=terminal display=main
      yabai -m rule --add app="WezTerm" space=terminal display=main
      yabai -m rule --add app="Warp" space=terminal display=main

      yabai -m rule --add app="Mail" space=mail display=main
      yabai -m rule --add app="Calendar" space=mail display=main
      yabai -m rule --add app="Canary" space=mail display=main

      ######################## Display left ########################
      yabai -m rule --add app="^zen" space=www display=left
      yabai -m rule --add app="^Safari" space=www display=left
      yabai -m rule --add app="^Sigma" space=www display=left
      yabai -m rule --add app="^Chrome" space=www display=left
      yabai -m rule --add app="^Brave" space=www display=left

      yabai -m rule --add app="Telegram" space=chat display=left
      yabai -m rule --add app="Mattermost" space=chat display=left

      ######################## Display right ########################
      yabai -m rule --add app="Code" space=code display=right
      yabai -m rule --add app="Sublime" space=code display=right
      yabai -m rule --add app="^Zed Preview$" space=code display=right
      yabai -m rule --add app="Neovide" space=code display=right

      yabai -m rule --add app="UpNote" space=todo display=right
      yabai -m rule --add app="Bear" space=todo display=right
      yabai -m rule --add app="Anytype" space=todo display=right
      yabai -m rule --add app="Craft" space=todo display=right

      echo "yabai configuration loaded.."
    '';
  };
}
