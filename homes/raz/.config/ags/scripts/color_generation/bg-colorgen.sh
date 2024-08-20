#!/usr/bin/env bash

# check if no arguments
if [ $# -eq 0 ]; then
    echo "Usage: colorgen.sh /path/to/image_or_hex_color (--apply)"
    exit 1
fi

# check if the file ~/.cache/ags/user/colormode.txt exists. if not, create it. else, read it to $lightdark
lightdark=""
if [ ! -f "$HOME/.cache/ags/user/colormode.txt" ]; then
    echo "" > "$HOME/.cache/ags/user/colormode.txt"
else
    lightdark=$(cat "$HOME/.cache/ags/user/colormode.txt") # either "" or "-l"
fi
backend="pywal" # color generator backend
if [ ! -f "$HOME/.cache/ags/user/colorbackend.txt" ]; then
    echo "material" > "$HOME/.cache/ags/user/colorbackend.txt"
else
    backend=$(cat "$HOME/.cache/ags/user/colorbackend.txt") # either "" or "-l"
fi

cd "$HOME/.config/ags/scripts/" || exit
if [[ "$1" = "#"* ]]; then # this is a color
    echo "Color detected"

    # load current wallpaper from cache
    if [ -f "$HOME/.cache/ags/user/wallpaper.txt" ]; then
        imgpath=$(cat "$HOME/.cache/ags/user/wallpaper.txt")
    else
        imgpath=""
    fi

    notify-send "Color detected"
    wal -c
    # Use Pywal to generate colors from the hex color
    wal -n $lightdark -q -b "$1" -i "$imgpath"
    echo "Generated colors with Pywal"
      # copy scss
    cp "$HOME/.cache/wal/colors.scss" "$HOME"/.cache/ags/user/generated/material_colors.scss

    cat color_generation/pywal_to_material.scss >> "$HOME"/.cache/ags/user/generated/material_colors.scss
    if [ "$2" = "--apply" ]; then
        sassc "$HOME"/.cache/ags/user/generated/material_colors.scss "$HOME"/.cache/ags/user/generated/colors_classes.scss --style compact
        sed -i "s/ { color//g" "$HOME"/.cache/ags/user/generated/colors_classes.scss
        sed -i "s/\./$/g" "$HOME"/.cache/ags/user/generated/colors_classes.scss
        sed -i "s/}//g" "$HOME"/.cache/ags/user/generated/colors_classes.scss
        if [ "$lightdark" = "-l" ]; then
            printf "\n""\$darkmode: false;""\n" >> "$HOME"/.cache/ags/user/generated/colors_classes.scss
        else
            printf "\n""\$darkmode: true;""\n" >> "$HOME"/.cache/ags/user/generated/colors_classes.scss
        fi
        cp "$HOME"/.cache/ags/user/generated/colors_classes.scss "$HOME/.config/ags/scss/_material.scss"
        color_generation/applycolor.sh
    fi
elif [ "$backend" = "material" ]; then
    echo "Running material..."
    color_generation/generate_colors_material.py --path "$1" "$lightdark" > "$HOME"/.cache/ags/user/generated/material_colors.scss
    if [ "$2" = "--apply" ]; then
        cp "$HOME"/.cache/ags/user/generated/material_colors.scss "$HOME/.config/ags/scss/_material.scss"
        color_generation/applycolor.sh
    fi
elif [ "$backend" = "pywal" ]; then
    # clear and generate
    echo "Running wal..."
    wal -c
    echo "Cleared wal cache"
    wal -i "$1" -n $lightdark -q
    echo "Generated colors"
    # copy scss
    cp "$HOME/.cache/wal/colors.scss" "$HOME"/.cache/ags/user/generated/material_colors.scss

    cat color_generation/pywal_to_material.scss >> "$HOME"/.cache/ags/user/generated/material_colors.scss
    if [ "$2" = "--apply" ]; then
        sassc "$HOME"/.cache/ags/user/generated/material_colors.scss "$HOME"/.cache/ags/user/generated/colors_classes.scss --style compact
        sed -i "s/ { color//g" "$HOME"/.cache/ags/user/generated/colors_classes.scss
        sed -i "s/\./$/g" "$HOME"/.cache/ags/user/generated/colors_classes.scss
        sed -i "s/}//g" "$HOME"/.cache/ags/user/generated/colors_classes.scss
        if [ "$lightdark" = "-l" ]; then
            printf "\n""\$darkmode: false;""\n" >> "$HOME"/.cache/ags/user/generated/colors_classes.scss
        else
            printf "\n""\$darkmode: true;""\n" >> "$HOME"/.cache/ags/user/generated/colors_classes.scss
        fi

        cp "$HOME"/.cache/ags/user/generated/colors_classes.scss "$HOME/.config/ags/scss/_material.scss"

        color_generation/applycolor.sh
    fi
fi
