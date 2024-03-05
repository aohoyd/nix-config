#!/opt/homebrew/bin/fish -N

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Focus right
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Yabai
# @raycast.icon images/yabai.png
#
# Documentation:
# @raycast.description Write a nice and descriptive summary about your script command here
# @raycast.author Alexey Olshanskiy
# @raycast.authorURL https://github.com/aohoyd

set -l PATH /run/current-system/sw/bin
set -l DIR east

yabai -m window --focus $DIR 2>/dev/null || \
  begin
    set -l visible (yabai -m query --windows --display $DIR | jq -r 'map(select(.["is-visible"]).id) | first')
    if test "$visible" = "null"
      yabai -m display --focus $DIR
    else
      yabai -m window --focus $visible
    end
  end
