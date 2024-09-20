#!/usr/bin/env bash

# Step 1: Create a new output
swaymsg create_output

# Step 2: Find the name of the newly created output
NEW_OUTPUT=$(swaymsg -t get_outputs | jq -r '.[] | select(.name | startswith("HEADLESS-")) | .name' | sort | tail -n 1)

# Check if the output was successfully created
if [ -z "$NEW_OUTPUT" ]; then
    echo "Failed to create a new output."
    exit 1
fi

# Step 3: Assign a workspace to the new output
swaymsg workspace sshr output "$NEW_OUTPUT"

# Step 4: Set the resolution for the new output
swaymsg output "$NEW_OUTPUT" resolution 1280x720

# Step 5: Set the background color for the new output
swaymsg output "$NEW_OUTPUT" bg "#220900" solid_color

# Step 6: Switch to workspace sshr and then back to the previous workspace
CURRENT_WORKSPACE=$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused) | .name')
swaymsg workspace sshr
swaymsg workspace "$CURRENT_WORKSPACE"

wl-mirror "$NEW_OUTPUT"

notify-send "Created new output $NEW_OUTPUT."
