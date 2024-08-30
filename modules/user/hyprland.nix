{ config, pkgs, ... }:

{
    home.file.".config/hypr/conf/animations.conf".text = ''

    # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
    #
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

    '';

    home.file.".config/hypr/conf/autostart.conf".text = ''

# Execute your favorite apps at launch
      exec-once = swaybg -i "$HOME/.dotfiles/wallpapers/current.jpg"
      exec-once = ~/.config/hypr/xdg-portal-hyprland
      exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      exec-once = systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      exec-once = /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1
      exec-once = swww init
      exec-once = waybar
      exec-once = mako
      exec-once = dunst
      exec-once = blueman-applet
      exec-once = nm-applet --indicator
      exec-once = wl-paste --watch cliphist store
      '';

    home.file.".config/hypr/conf/binds.conf".text = ''

# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more

# SUPER key
$mainMod = SUPER

# Actions
bind = $mainMod, RETURN, exec, alacritty  #open the terminal
bind = $mainMod, Q, killactive, # close the active window
bind = $mainMod, P, exec, rofi -show run
bind = $mainMod, BACKSPACE, exec, brave
bind = $mainMod, F, fullscreen,
bind = $mainMod, E, exec, thunar # Show the graphical file browser
bind = $mainMod, V, togglefloating, # Allow a window to float
bind = $mainMod, D, pseudo, # dwindle
bind = $mainMod, J, togglesplit, # dwindle
bind = $mainMod, S, exec, grimblast --notify --cursor copysave area
bind = , Print, exec, grimblast --notify --cursor copysave area

# Move focus with mainMod + arrow keys
bind = $mainMod, left, movefocus, l # Move focus left
bind = $mainMod, right, movefocus, r # Move focus right
bind = $mainMod, up, movefocus, u # Move focus up
bind = $mainMod, down, movefocus, d # Move focus down

# Switch workspaces with mainMod + [0-9]
bind = $mainMod, 1, workspace, 1 # Switch to workspace 1
bind = $mainMod, 2, workspace, 2 # Switch to workspace 2
bind = $mainMod, 3, workspace, 3 # Switch to workspace 3
bind = $mainMod, 4, workspace, 4 # Switch to workspace 4
bind = $mainMod, 5, workspace, 5 # Switch to workspace 5
bind = $mainMod, 6, workspace, 6 # Switch to workspace 6
bind = $mainMod, 7, workspace, 7 # Switch to workspace 7
bind = $mainMod, 8, workspace, 8 # Switch to workspace 8
bind = $mainMod, 9, workspace, 9 # Switch to workspace 9
bind = $mainMod, 0, workspace, 10 # Switch to workspace 10

# Move active window to a workspace with mainMod + SHIFT + [0-9]
bind = $mainMod SHIFT, 1, movetoworkspace, 1 #  Move window to workspace 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2 #  Move window to workspace 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3 #  Move window to workspace 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4 #  Move window to workspace 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5 #  Move window to workspace 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6 #  Move window to workspace 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7 #  Move window to workspace 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8 #  Move window to workspace 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9 #  Move window to workspace 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10 #  Move window to workspace 10

# Scroll through existing workspaces with mainMod + scroll
bind = $mainMod, mouse_down, workspace, e+1 # Scroll workspaces 
bind = $mainMod, mouse_up, workspace, e-1 # Scroll workspaces

# Move/resize windows with mainMod + LMB/RMB and dragging
bindm = $mainMod, mouse:272, movewindow # Move window
bindm = $mainMod, mouse:273, resizewindow # Resize window

    '';

    home.file.".config/hypr/conf/decoration.conf".text = ''

# See https://wiki.hyprland.org/Configuring/Variables/ for more
      decoration {
        rounding = 5
          blur {
            enabled = true
              size = 3
              passes = 1
          }
        drop_shadow = true
          shadow_range = 8
          shadow_render_power = 3
          col.shadow = rgba(1a1a1aee)
      }


    '';
    home.file.".config/hypr/conf/environments.conf".text = ''

      # XDG Desktop Portal
      env = XDG_CURRENT_DESKTOP,Hyprland
      env = XDG_SESSION_TYPE,wayland
      env = XDG_SESSION_DESKTOP,Hyprland

      # QT
      env = QT_QPA_PLATFORM,wayland;xcb
      env = QT_QPA_PLATFORMTHEME,qt6ct
      env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
      env = QT_AUTO_SCREEN_SCALE_FACTOR,1

      # GTK
      env = GDK_SCALE,1

      # Mozilla
      env = MOZ_ENABLE_WAYLAND,1

      # Set the cursor size for xcursor
      env = XCURSOR_SIZE,18

      # Disable appimage launcher by default
      env = APPIMAGELAUNCHER_DISABLE,1

      # OZONE
      env = OZONE_PLATFORM,wayland

      # For KVM virtual machines
      # env = WLR_NO_HARDWARE_CURSORS, 1
      # env = WLR_RENDERER_ALLOW_SOFTWARE, 1

      # NVIDIA https://wiki.hyprland.org/Nvidia/
      env = LIBVA_DRIVER_NAME,nvidia
      env = GBM_BACKEND,nvidia-drm
      env = __GLX_VENDOR_LIBRARY_NAME,nvidia
      env = __GL_VRR_ALLOWED,1
      env = WLR_DRM_NO_ATOMIC,1


    '';

    home.file.".config/hypr/conf/general.conf".text = ''

      # See https://wiki.hyprland.org/Configuring/Variables/ for more
      general {
        gaps_in = 5
          gaps_out = 5
          border_size = 1
          col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
          col.inactive_border = rgba(595959aa)
          layout = dwindle
          resize_on_border = true
      }
    '';

    home.file.".config/hypr/conf/gestures.conf".text = ''

      # See https://wiki.hyprland.org/Configuring/Variables/ for more
      gestures {
        workspace_swipe = true
      }
    '';

    home.file.".config/hypr/conf/input.conf".text = ''

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input {
        kb_layout = no
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =

          repeat_delay = 300
          repeat_rate = 50

          follow_mouse = 1

          touchpad {
            natural_scroll = false
          }

        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }

    '';

    home.file.".config/hypr/conf/layouts.conf".text = ''

      dwindle {
        # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
        pseudotile = true # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = true # you probably want this
      }

    master {
    # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
    # new_status = master
    }

    '';

    home.file.".config/hypr/conf/misc.conf".text = ''

      # See https://wiki.hyprland.org/Configuring/Variables/ for more
      misc {
        disable_hyprland_logo = true
          disable_splash_rendering = true
      }

    '';
    home.file.".config/hypr/conf/monitors.conf".text = ''

      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor=,highrr,auto,1

    '';

    home.file.".config/hypr/hyprland.conf".text = ''


#  _   _                  _                 _  
# | | | |_   _ _ __  _ __| | __ _ _ __   __| | 
# | |_| | | | | '_ \| '__| |/ _` | '_ \ / _` | 
# |  _  | |_| | |_) | |  | | (_| | | | | (_| | 
# |_| |_|\__, | .__/|_|  |_|\__,_|_| |_|\__,_| 
#        |___/|_|                              
#  
# ----------------------------------------------------- 
# Full documentation https://wiki.hyprland.org

    source = ~/.config/hypr/conf/monitors.conf
    source = ~/.config/hypr/conf/autostart.conf
    source = ~/.config/hypr/conf/environments.conf
    source = ~/.config/hypr/conf/input.conf
    source = ~/.config/hypr/conf/general.conf
    source = ~/.config/hypr/conf/decoration.conf
    source = ~/.config/hypr/conf/animations.conf
    source = ~/.config/hypr/conf/layouts.conf
    source = ~/.config/hypr/conf/gestures.conf
    source = ~/.config/hypr/conf/misc.conf
    source = ~/.config/hypr/conf/binds.conf
    '';

    home.file.".config/dunst/dunstrc".text = ''
    
    #      _                 _    
#   __| |_   _ _ __  ___| |_  
#  / _` | | | | '_ \/ __| __| 
# | (_| | |_| | | | \__ \ |_  
#  \__,_|\__,_|_| |_|___/\__| 
#                             
#  

# See dunst(5) for all configuration options

[global]
    ### Display ###

    # Which monitor should the notifications be displayed on.
    monitor = 0

    # Display notification on focused monitor.  Possible modes are:
    #   mouse: follow mouse pointer
    #   keyboard: follow window with keyboard focus
    #   none: don't follow anything
    #
    # "keyboard" needs a window manager that exports the
    # _NET_ACTIVE_WINDOW property.
    # This should be the case for almost all modern window managers.
    #
    # If this option is set to mouse or keyboard, the monitor option
    # will be ignored.
    follow = none

    ### Geometry ###

    # dynamic width from 0 to 300
    # width = (0, 300)
    # constant width of 300
    width = 300

    # The maximum height of a single notification, excluding the frame.
    height = (0,300)

    # Position the notification in the top right corner
    origin = top-center

    # Offset from the origin
    offset = 0x30

    # Scale factor. It is auto-detected if value is 0.
    scale = 0

    # Maximum number of notification (0 means no limit)
    notification_limit = 20

    ### Progress bar ###

    # Turn on the progess bar. It appears when a progress hint is passed with
    # for example dunstify -h int:value:12
    progress_bar = true

    # Set the progress bar height. This includes the frame, so make sure
    # it's at least twice as big as the frame width.
    progress_bar_height = 10

    # Set the frame width of the progress bar
    progress_bar_frame_width = 1

    # Set the minimum width for the progress bar
    progress_bar_min_width = 150

    # Set the maximum width for the progress bar
    progress_bar_max_width = 300

    # Corner radius for the progress bar. 0 disables rounded corners.
    progress_bar_corner_radius = 10

    # Corner radius for the icon image.
    icon_corner_radius = 0

    # Show how many messages are currently hidden (because of
    # notification_limit).
    indicate_hidden = yes

    # The transparency of the window.  Range: [0; 100].
    # This option will only work if a compositing window manager is
    # present (e.g. xcompmgr, compiz, etc.). (X11 only)
    transparency = 30

    # Draw a line of "separator_height" pixel height between two
    # notifications.
    # Set to 0 to disable.
    # If gap_size is greater than 0, this setting will be ignored.
    separator_height = 2

    # Padding between text and separator.
    padding = 8

    # Horizontal padding.
    horizontal_padding = 8

    # Padding between text and icon.
    text_icon_padding = 0

    # Defines width in pixels of frame around the notification window.
    # Set to 0 to disable.
    frame_width = 1

    # Defines color of the frame around the notification window.
    frame_color = "#ffffff"

    # Size of gap to display between notifications - requires a compositor.
    # If value is greater than 0, separator_height will be ignored and a border
    # of size frame_width will be drawn around each notification instead.
    # Click events on gaps do not currently propagate to applications below.
    gap_size = 0

    # Define a color for the separator.
    # possible values are:
    #  * auto: dunst tries to find a color fitting to the background;
    #  * foreground: use the same color as the foreground;
    #  * frame: use the same color as the frame;
    #  * anything else will be interpreted as a X color.
    separator_color = frame

    # Sort messages by urgency.
    sort = yes

    # Don't remove messages, if the user is idle (no mouse or keyboard input)
    # for longer than idle_threshold seconds.
    # Set to 0 to disable.
    # A client can set the 'transient' hint to bypass this. See the rules
    # section for how to disable this if necessary
    # idle_threshold = 120

    ### Text ###

    font = "Fira Sans Semibold" 9

    # The spacing between lines.  If the height is smaller than the
    # font height, it will get raised to the font height.
    line_height = 1

    # Possible values are:
    # full: Allow a small subset of html markup in notifications:
    #        <b>bold</b>
    #        <i>italic</i>
    #        <s>strikethrough</s>
    #        <u>underline</u>
    #
    #        For a complete reference see
    #        <https://docs.gtk.org/Pango/pango_markup.html>.
    #
    # strip: This setting is provided for compatibility with some broken
    #        clients that send markup even though it's not enabled on the
    #        server. Dunst will try to strip the markup but the parsing is
    #        simplistic so using this option outside of matching rules for
    #        specific applications *IS GREATLY DISCOURAGED*.
    #
    # no:    Disable markup parsing, incoming notifications will be treated as
    #        plain text. Dunst will not advertise that it has the body-markup
    #        capability if this is set as a global setting.
    #
    # It's important to note that markup inside the format option will be parsed
    # regardless of what this is set to.
    markup = full

    # The format of the message.  Possible variables are:
    #   %a  appname
    #   %s  summary
    #   %b  body
    #   %i  iconname (including its path)
    #   %I  iconname (without its path)
    #   %p  progress value if set ([  0%] to [100%]) or nothing
    #   %n  progress value if set without any extra characters
    #   %%  Literal %
    # Markup is allowed
    format = "<b>%s</b>\n%b"

    # Alignment of message text.
    # Possible values are "left", "center" and "right".
    alignment = left

    # Vertical alignment of message text and icon.
    # Possible values are "top", "center" and "bottom".
    vertical_alignment = center

    # Show age of message if message is older than show_age_threshold
    # seconds.
    # Set to -1 to disable.
    show_age_threshold = 60

    # Specify where to make an ellipsis in long lines.
    # Possible values are "start", "middle" and "end".
    ellipsize = middle

    # Ignore newlines '\n' in notifications.
    ignore_newline = no

    # Stack together notifications with the same content
    stack_duplicates = true

    # Hide the count of stacked notifications with the same content
    hide_duplicate_count = false

    # Display indicators for URLs (U) and actions (A).
    show_indicators = yes

    ### Icons ###

    # Recursive icon lookup. You can set a single theme, instead of having to
    # define all lookup paths.
    enable_recursive_icon_lookup = true

    # Set icon theme (only used for recursive icon lookup)
    icon_theme = "Papirus-Dark,Adwaita"
    # You can also set multiple icon themes, with the leftmost one being used first.
    # icon_theme = "Adwaita, breeze"

    # Align icons left/right/top/off
    icon_position = left

    # Scale small icons up to this size, set to 0 to disable. Helpful
    # for e.g. small files or high-dpi screens. In case of conflict,
    # max_icon_size takes precedence over this.
    min_icon_size = 32

    # Scale larger icons down to this size, set to 0 to disable
    max_icon_size = 128

    # Paths to default icons (only neccesary when not using recursive icon lookup)
    icon_path = /usr/share/icons/gnome/16x16/status/:/usr/share/icons/gnome/16x16/devices/

    ### History ###

    # Should a notification popped up from history be sticky or timeout
    # as if it would normally do.
    sticky_history = yes

    # Maximum amount of notifications kept in history
    history_length = 20

    ### Misc/Advanced ###

    # dmenu path.
    dmenu = /usr/bin/dmenu -p dunst:

    # Browser for opening urls in context menu.
    browser = /usr/bin/xdg-open

    # Always run rule-defined scripts, even if the notification is suppressed
    always_run_script = true

    # Define the title of the windows spawned by dunst
    title = Dunst

    # Define the class of the windows spawned by dunst
    class = Dunst

    # Define the corner radius of the notification window
    # in pixel size. If the radius is 0, you have no rounded
    # corners.
    # The radius will be automatically lowered if it exceeds half of the
    # notification height to avoid clipping text and/or icons.
    corner_radius = 10

    # Ignore the dbus closeNotification message.
    # Useful to enforce the timeout set by dunst configuration. Without this
    # parameter, an application may close the notification sent before the
    # user defined timeout.
    ignore_dbusclose = false

    ### Wayland ###
    # These settings are Wayland-specific. They have no effect when using X11

    # Uncomment this if you want to let notications appear under fullscreen
    # applications (default: overlay)
    # layer = top

    # Set this to true to use X11 output on Wayland.
    force_xwayland = false

    ### Legacy

    # Use the Xinerama extension instead of RandR for multi-monitor support.
    # This setting is provided for compatibility with older nVidia drivers that
    # do not support RandR and using it on systems that support RandR is highly
    # discouraged.
    #
    # By enabling this setting dunst will not be able to detect when a monitor
    # is connected or disconnected which might break follow mode if the screen
    # layout changes.
    force_xinerama = false

    ### mouse

    # Defines list of actions for each mouse event
    # Possible values are:
    # * none: Don't do anything.
    # * do_action: Invoke the action determined by the action_name rule. If there is no
    #              such action, open the context menu.
    # * open_url: If the notification has exactly one url, open it. If there are multiple
    #             ones, open the context menu.
    # * close_current: Close current notification.
    # * close_all: Close all notifications.
    # * context: Open context menu for the notification.
    # * context_all: Open context menu for all notifications.
    # These values can be strung together for each mouse event, and
    # will be executed in sequence.
    mouse_left_click = close_current
    mouse_middle_click = do_action, close_current
    mouse_right_click = close_all

# Experimental features that may or may not work correctly. Do not expect them
# to have a consistent behaviour across releases.
[experimental]
    # Calculate the dpi to use on a per-monitor basis.
    # If this setting is enabled the Xft.dpi value will be ignored and instead
    # dunst will attempt to calculate an appropriate dpi value for each monitor
    # using the resolution and physical size. This might be useful in setups
    # where there are multiple screens with very different dpi values.
    per_monitor_dpi = false


[urgency_low]
    # IMPORTANT: colors have to be defined in quotation marks.
    # Otherwise the "#" and following would be interpreted as a comment.
    background = "#000000CC"
    foreground = "#888888"
    timeout = 6
    # Icon for notifications with low urgency, uncomment to enable
    #default_icon = /path/to/icon

[urgency_normal]
    background = "#000000CC"
    foreground = "#ffffff"
    timeout = 6
    # Icon for notifications with normal urgency, uncomment to enable
    #default_icon = /path/to/icon

[urgency_critical]
    background = "#900000CC"
    foreground = "#ffffff"
    frame_color = "#ffffff"
    timeout = 6
    # Icon for notifications with critical urgency, uncomment to enable
    #default_icon = /path/to/icon

# Every section that isn't one of the above is interpreted as a rules to
# override settings for certain messages.
#
# Messages can be matched by
#    appname (discouraged, see desktop_entry)
#    body
#    category
#    desktop_entry
#    icon
#    match_transient
#    msg_urgency
#    stack_tag
#    summary
#
# and you can override the
#    background
#    foreground
#    format
#    frame_color
#    fullscreen
#    new_icon
#    set_stack_tag
#    set_transient
#    set_category
#    timeout
#    urgency
#    icon_position
#    skip_display
#    history_ignore
#    action_name
#    word_wrap
#    ellipsize
#    alignment
#    hide_text
#
# Shell-like globbing will get expanded.
#
# Instead of the appname filter, it's recommended to use the desktop_entry filter.
# GLib based applications export their desktop-entry name. In comparison to the appname,
# the desktop-entry won't get localized.
#
# SCRIPTING
# You can specify a script that gets run when the rule matches by
# setting the "script" option.
# The script will be called as follows:
#   script appname summary body icon urgency
# where urgency can be "LOW", "NORMAL" or "CRITICAL".
#
# NOTE: It might be helpful to run dunst -print in a terminal in order
# to find fitting options for rules.

# Disable the transient hint so that idle_threshold cannot be bypassed from the
# client
#[transient_disable]
#    match_transient = yes
#    set_transient = no
#
# Make the handling of transient notifications more strict by making them not
# be placed in history.
#[transient_history_ignore]
#    match_transient = yes
#    history_ignore = yes

# fullscreen values
# show: show the notifications, regardless if there is a fullscreen window opened
# delay: displays the new notification, if there is no fullscreen window active
#        If the notification is already drawn, it won't get undrawn.
# pushback: same as delay, but when switching into fullscreen, the notification will get
#           withdrawn from screen again and will get delayed like a new notification
#[fullscreen_delay_everything]
#    fullscreen = delay
#[fullscreen_show_critical]
#    msg_urgency = critical
#    fullscreen = show

#[espeak]
#    summary = "*"
#    script = dunst_espeak.sh

#[script-test]
#    summary = "*script*"
#    script = dunst_test.sh

#[ignore]
#    # This notification will not be displayed
#    summary = "foobar"
#    skip_display = true

#[history-ignore]
#    # This notification will not be saved in history
#    summary = "foobar"
#    history_ignore = yes

#[skip-display]
#    # This notification will not be displayed, but will be included in the history
#    summary = "foobar"
#    skip_display = yes

#[signed_on]
#    appname = Pidgin
#    summary = "*signed on*"
#    urgency = low
#
#[signed_off]
#    appname = Pidgin
#    summary = *signed off*
#    urgency = low
#
#[says]
#    appname = Pidgin
#    summary = *says*
#    urgency = critical
#
#[twitter]
#    appname = Pidgin
#    summary = *twitter.com*
#    urgency = normal
#
#[stack-volumes]
#    appname = "some_volume_notifiers"
#    set_stack_tag = "volume"
#
# vim: ft=cfg

    '';





    home.packages = with pkgs; [
        swaybg
        rofi-wayland
        grim
        swappy
        shotman
        slurp
        xfce.thunar
        foot
        dunst
    ];

}
