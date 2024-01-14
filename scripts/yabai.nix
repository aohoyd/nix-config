        # change window focus within space
        cmd + ctrl + alt - down : yabai -m window --focus south
        cmd + ctrl + alt - up : yabai -m window --focus north
        cmd + ctrl + alt - left : if [ (yabai -m query --spaces --space | jq -r .type) = "stack" ]; yabai -m window --focus stack.prev; else; yabai -m window --focus west; end
        cmd + ctrl + alt - right : if [ (yabai -m query --spaces --space | jq -r .type) = "stack" ]; yabai -m window --focus stack.next; else; yabai -m window --focus east; end

        cmd + ctrl + alt - 0x2B : yabai -m window --focus stack.prev
        cmd + ctrl + alt - 0x2F : yabai -m window --focus stack.next

        cmd + ctrl + alt - t : if [ (yabai -m query --spaces --space | jq -r .type) = "stack" ]; yabai -m space --layout bsp; else; yabai -m space --layout stack; end

        # move window to display left and right
        cmd + ctrl + alt - c : yabai -m window --display north; yabai -m display --focus north;
        cmd + ctrl + alt - x : yabai -m window --display south; yabai -m display --focus south;
        cmd + ctrl + alt - z : yabai -m window --display west; yabai -m display --focus west;
        cmd + ctrl + alt - v : yabai -m window --display east; yabai -m display --focus east;

        # rotate layout clockwise
        cmd + ctrl + alt - r : yabai -m space --rotate 270

        # toggle window float
        cmd + ctrl +  alt - f : yabai -m window --toggle float --grid 4:4:1:1:2:2
        cmd + ctrl + alt - q : yabai -m query --windows --space | jq '.[] | select(.["is-floating"]).id' | while read -l w; yabai -m window $w --toggle float; end
        cmd + ctrl + alt - s : yabai -m query --windows --space | jq '.[2:][] | .id' | while read -l w; yabai -m window --stack $w; end

        # maximize a window
        cmd + ctrl + alt - g : set -l args -m window --toggle zoom-fullscreen; if [ (yabai -m query --windows --window | jq '.["is-floating"]') = "true" ]; set args $args[1..2] --toggle float $args[3..4]; end; yabai $args
        cmd + ctrl + shift + alt - g : yabai -m window --toggle native-fullscreen

        # balance out tree of windows (resize to occupy same area)
        cmd + ctrl + shift + alt - e : yabai -m space --balance

        # swap windows
        cmd + ctrl + shift + alt - down : yabai -m window --swap south
        cmd + ctrl + shift + alt - up : yabai -m window --swap north
        cmd + ctrl + shift + alt - left : yabai -m window --swap west
        cmd + ctrl + shift + alt - right : yabai -m window --swap east

        cmd + ctrl + shift + alt - a : set -l s (yabai -m query --windows --window west | jq -r .id); if [ -n "$s" ]; yabai -m window $s --stack (yabai -m query --windows --window | jq -r .id); end
        cmd + ctrl + shift + alt - d : set -l s (yabai -m query --windows --window east | jq -r .id); if [ -n "$s" ]; yabai -m window $s --stack (yabai -m query --windows --window | jq -r .id); end

        # move window and split
        ctrl + alt + shift - 2 : yabai -m window --warp south
        ctrl + alt + shift - 3 : yabai -m window --warp north
        ctrl + alt + shift - 1 : yabai -m window --warp west
        ctrl + alt + shift - 4 : yabai -m window --warp east

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
        cmd + ctrl + shift + alt - z : if test -z (launchctl list | grep org.nixos.yabai); launchctl load ~/Library/LaunchAgents/org.nixos.yabai.plist; else; launchctl unload ~/Library/LaunchAgents/org.nixos.yabai.plist; end
