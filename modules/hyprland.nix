{ config, pkgs, ... }:

{
    home.file.".config/hypr/hyprland.conf".text = ''

        # Setup monitors
# See https://wiki.hyprland.org/Configuring/Monitors/
#monitor=,preferred,auto,1
monitor=,3440x1440@165,auto,1

# Dual monitor example on G15 Strix
# eDP-1 is the built in monitor while DP-1 is external
# Both monitors here are at 1440 and 165Hz
# DP-1 is on the left and  eDP-1 is on the right
#monitor=DP-1,2560x1440@165,0x0,1
#monitor=eDP-1,2560x1440@165,2560x0,1

# See https://wiki.hyprland.org/Configuring/Keywords/ for more

# Execute your favorite apps at launch
exec-once = swaybg -i "$HOME/.dotfiles/wallpapers/1.jpg"
exec-once = ~/.config/hypr/xdg-portal-hyprland
exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
exec-once = /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
exec-once = swww init
exec-once = waybar
exec-once = mako
exec-once = blueman-applet
exec-once = nm-applet --indicator
exec-once = wl-paste --watch cliphist store

# For all categories, see https://wiki.hyprland.org/Configuring/Variables/
input {
    kb_layout = no
    kb_variant =
    kb_model =
    kb_options =
    kb_rules =

    follow_mouse = 1

    touchpad {
        natural_scroll = no
    }

    sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
}

general {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more

    gaps_in = 5
    gaps_out = 10
    border_size = 2
    #col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
    col.active_border=rgb(cdd6f4)
    col.inactive_border = rgba(595959aa)

    layout = dwindle
}

misc {
    disable_hyprland_logo = yes
}

decoration {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more

    rounding = 5
    
    blur {
        enabled = true
        size = 7
        passes = 4
        new_optimizations = true
    }

    blurls = lockscreen

    drop_shadow = yes
    shadow_range = 4
    shadow_render_power = 3
    col.shadow = rgba(1a1a1aee)
}

animations {
    enabled = yes

    # Define Settings For Animation Bezier Curve
    bezier = wind, 0.05, 0.9, 0.1, 1.05
    bezier = winIn, 0.1, 1.1, 0.1, 1.1
    bezier = winOut, 0.3, -0.3, 0, 1
    bezier = liner, 1, 1, 1, 1

    animation = windows, 1, 6, wind, slide
    animation = windowsIn, 1, 6, winIn, slide
    animation = windowsOut, 1, 5, winOut, slide
    animation = windowsMove, 1, 5, wind, slide
    animation = border, 1, 1, liner
    animation = borderangle, 1, 30, liner, loop
    animation = fade, 1, 10, default
    animation = workspaces, 1, 5, wind
}

dwindle {
    # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
    pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
    preserve_split = yes # you probably want this
}

master {
    # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
    new_is_master = true
}

gestures {
    # See https://wiki.hyprland.org/Configuring/Variables/ for more
    workspace_swipe = off
}


# Example windowrule v1
#windowrule = float, ^(kitty)$
windowrule = float,^(pavucontrol)$
windowrule = float,^(blueman-manager)$
windowrule = float,^(nm-connection-editor)$
windowrule = float,^(chromium)$
windowrule = float,^(thunar)$
windowrule = float, title:^(btop)$
windowrule = float, title:^(update-sys)$

# Example windowrule v2
# windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
# See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
# rules below would make the specific app transparent
windowrulev2 = opacity 0.8 0.8,class:^(kitty)$
windowrulev2 = animation popin,class:^(kitty)$,title:^(update-sys)$
windowrulev2 = animation popin,class:^(thunar)$
windowrulev2 = opacity 0.8 0.8,class:^(thunar)$
windowrulev2 = opacity 0.8 0.8,class:^(VSCodium)$
windowrulev2 = animation popin,class:^(chromium)$
windowrulev2 = move cursor -3% -105%,class:^(wofi)$
windowrulev2 = noanim,class:^(wofi)$
windowrulev2 = opacity 0.8 0.6,class:^(wofi)$


# See https://wiki.hyprland.org/Configuring/Keywords/ for more
$mainMod = SUPER

# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
bind = $mainMod, RETURN, exec, alacritty  #open the terminal
bind = $mainMod, Q, killactive, # close the active window
bind = $mainMod, P, exec, rofi -show run
bind = $mainMod, BACKSPACE, exec, brave
bind = $mainMod, F, fullscreen,
bind = $mainMod, E, exec, thunar # Show the graphical file browser
bind = $mainMod, V, togglefloating, # Allow a window to float
bind = $mainMod, D, pseudo, # dwindle
bind = $mainMod, J, togglesplit, # dwindle
bind = $mainMod, S, exec, grim -g "$(slurp)" - | swappy -f - # take a screenshot
bind = , Print, exec, grimblast copy area
bind = $mainMod, F12, exec, wdisplays

# Move focus with mainMod + arrow keys
bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d

# Switch workspaces with mainMod + [0-9]
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

# Move active window to a workspace with mainMod + SHIFT + [0-9]
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

# Scroll through existing workspaces with mainMod + scroll
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

# Move/resize windows with mainMod + LMB/RMB and dragging
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

env = WLR_NO_HARDWARE_CURSORS,1
env = LIBVA_DRIVER_NAME,nvidia


    '';

    home.packages = with pkgs; [
        swaybg
        rofi-wayland
        grim
        slurp
        xfce.thunar
        foot
        dunst
    ];

}
