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

if test (/run/current-system/sw/bin/yabai -m query --spaces --space | /run/current-system/sw/bin/jq -r '.type') = "stack"
    /run/current-system/sw/bin/yabai -m window --focus stack.next
else
    /run/current-system/sw/bin/yabai -m window --focus east
end 2>/dev/null || true
