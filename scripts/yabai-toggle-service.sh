#!/opt/homebrew/bin/fish -N

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Service
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

if test -z (launchctl list | grep org.nixos.yabai)
  launchctl load ~/Library/LaunchAgents/org.nixos.yabai.plist
else
  launchctl unload ~/Library/LaunchAgents/org.nixos.yabai.plist
end
