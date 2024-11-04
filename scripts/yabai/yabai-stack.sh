#!/opt/homebrew/bin/fish -N

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Stack
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
set -l split_child (yabai -m query --windows --window | jq -r '.["split-child"]')
switch $split_child
    case first_child
        yabai -m window --stack next
    case second_child
        yabai -m window --stack prev
    case '*'
        echo "Not a split window" >&2
        exit 1
end
