{config, lib, ...}:
{
  home.file.yabai = {
    executable = true;
    target = ".config/yabai/yabairc";
    text = ''
      #!/usr/bin/env sh

      # load scripting addition
      #sudo yabai --load-sa
      #yabai -m signal --add event=dock_did_restart action="sudo yabai --load-sa"

      # center mouse on window with focus
      yabai -m config mouse_follows_focus on

      # modifier for clicking and dragging with mouse
      yabai -m config mouse_modifier alt
      # set modifier + left-click drag to move window
      yabai -m config mouse_action1 move
      # set modifier + right-click drag to resize window
      yabai -m config mouse_action2 resize


      # when window is dropped in center of another window, swap them (on edges it will split it)
      yabai -m mouse_drop_action swap

      # borders
      yabai -m config window_border on
      yabai -m config window_border_width 2
      yabai -m config window_border_radius 0
      yabai -m config window_border_blur off
      yabai -m config active_window_border_color 0xFF40FF00
      yabai -m config normal_window_border_color 0x00FFFFFF
      yabai -m config insert_feedback_color 0xffd75f5f

      yabai -m config window_shadow off

      # layout
      yabai -m config layout bsp
      yabai -m config auto_balance off
      yabai -m config window_topmost on

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

      # workspace management
      yabai -m space 1 --label www
      yabai -m space 2 --label code
      yabai -m space 3 --label ide
      yabai -m space 4 --label chat
      yabai -m space 5 --label todo
      yabai -m space 6 --label mail
      yabai -m space 7 --label term

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

      yabai -m rule --add app="WezTerm" space=term

      echo "yabai configuration loaded.."
    '';
  };

  home.file.skhd = {
    target = ".config/skhd/skhdrc";
    text = ''
        # change window focus within space
        cmd + ctrl + alt - s : yabai -m window --focus south
        cmd + ctrl + alt - d : yabai -m window --focus north
        cmd + ctrl + alt - a : if [ (yabai -m query --spaces --space | jq -r .type) = "stack" ]; yabai -m window --focus stack.prev; else; yabai -m window --focus west; end
        cmd + ctrl + alt - f : if [ (yabai -m query --spaces --space | jq -r .type) = "stack" ]; yabai -m window --focus stack.next; else; yabai -m window --focus east; end

        cmd + ctrl + alt - t : if [ (yabai -m query --spaces --space | jq -r .type) = "stack" ]; yabai -m space --layout bsp; else; yabai -m space --layout stack; end

        #change focus between external displays (left and right)
        cmd + ctrl + alt - c: yabai -m display --focus north
        cmd + ctrl + alt - x: yabai -m display --focus south

        # rotate layout clockwise
        cmd + ctrl + alt - r : yabai -m space --rotate 270

        # flip along y-axis
        #shift + alt - y : yabai -m space --mirror y-axis

        # flip along x-axis
        #shift + alt - x : yabai -m space --mirror x-axis

        # toggle window float
        cmd + ctrl + shift + alt - t : yabai -m window --toggle float --grid 4:4:1:1:2:2

        # maximize a window
        cmd + ctrl + alt - g : yabai -m window --toggle zoom-fullscreen

        # balance out tree of windows (resize to occupy same area)
        cmd + ctrl + shift + alt - e : yabai -m space --balance

        # swap windows
        cmd + ctrl + shift + alt - s : yabai -m window --swap south
        cmd + ctrl + shift + alt - d : yabai -m window --swap north
        cmd + ctrl + shift + alt - a : yabai -m window --swap west
        cmd + ctrl + shift + alt - f : yabai -m window --swap east

        # move window and split
        ctrl + alt + shift - 2 : yabai -m window --warp south
        ctrl + alt + shift - 3 : yabai -m window --warp north
        ctrl + alt + shift - 1 : yabai -m window --warp west
        ctrl + alt + shift - 4 : yabai -m window --warp east

        # move window to display left and right
        cmd + ctrl + shift + alt - c : yabai -m window --display north; yabai -m display --focus north;
        cmd + ctrl + shift + alt - x : yabai -m window --display south; yabai -m display --focus south;

        #move window to prev and next space
        #shift + alt - p : yabai -m window --space prev;
        #shift + alt - n : yabai -m window --space next;

        # move window to space #
        #shift + alt - 1 : yabai -m window --space 1;
        #shift + alt - 2 : yabai -m window --space 2;
        #shift + alt - 3 : yabai -m window --space 3;
        #shift + alt - 4 : yabai -m window --space 4;
        #shift + alt - 5 : yabai -m window --space 5;
        #shift + alt - 6 : yabai -m window --space 6;
        #shift + alt - 7 : yabai -m window --space 7;

        # stop/start/restart yabai
        cmd + ctrl + alt - z : if test -z (launchctl list | grep org.nixos.yabai); launchctl load ~/Library/LaunchAgents/org.nixos.yabai.plist; else; launchctl unload ~/Library/LaunchAgents/org.nixos.yabai.plist; end
      '';
  };
}
