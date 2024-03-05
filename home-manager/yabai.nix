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
      yabai -m display 1 --label _123
      yabai -m display 2 --label _456
      yabai -m display 3 --label _78

      yabai -m space 1 --label code
      yabai -m space 2 --label ide
      yabai -m space 3 --label mail
      yabai -m space 4 --label www
      yabai -m space 5 --label chat
      yabai -m space 6 --label todo
      yabai -m space 7 --label terminal

      yabai -m config --space 2 layout stack
      yabai -m config --space 3 layout stack

      # assign apps to spaces
      
      ######################## Display 1 ########################
      yabai -m rule --add app="Code" space=code display=_123
      yabai -m rule --add app="Sublime" space=code display=_123
      yabai -m rule --add app="Zed" space=code display=_123
      yabai -m rule --add app="Neovide" space=code display=_123

      yabai -m rule --add app="PyCharm" space=ide display=_123
      yabai -m rule --add app="GoLand" space=ide display=_123
      yabai -m rule --add app="Lens" space=ide display=_123

      yabai -m rule --add app="Mail" space=mail display=_123
      yabai -m rule --add app="Canary" space=mail display=_123

      ######################## Display 2 ########################
      yabai -m rule --add app="Arc" space=www display=_456

      yabai -m rule --add app="Telegram" space=chat display=_456
      yabai -m rule --add app="Mattermost" space=chat display=_456

      yabai -m rule --add app="UpNote" space=todo display=_456
      yabai -m rule --add app="Bear" space=todo display=_456
      yabai -m rule --add app="Anytype" space=todo display=_456
      yabai -m rule --add app="Craft" space=todo display=_456

      ######################## Display 3 ########################
      yabai -m rule --add app="kitty" space=terminal display=_78
      yabai -m rule --add app="WezTerm" space=terminal display=_78

      echo "yabai configuration loaded.."
    '';
  };
}
