#!/opt/homebrew/bin/fish -N

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Restart
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

/bin/launchctl unload /Users/$USER/Library/LaunchAgents/org.nixos.yabai.plist || true
/bin/launchctl load /Users/$USER/Library/LaunchAgents/org.nixos.yabai.plist
