{ config, pkgs, ... }:

{
    home.file.".config/waybar/style.css".text = ''

@define-color background-modules rgba(0, 0, 0, 0.2);
@define-color text-color #FFFFFF;
@define-color workspace-hover rgba(255, 255, 255, 0.2);

/* -----------------------------------------------------
 * General 
 * ----------------------------------------------------- */

* {
    font-family: "Fira Sans Semibold", FontAwesome, Roboto, Helvetica, Arial, sans-serif;
    border: none;
    border-radius: 0px;
}

window#waybar {
    background: rgba(21, 18, 27, 0);
    color: #cdd6f4;
}

/* -----------------------------------------------------
 * Workspaces 
 * ----------------------------------------------------- */

#workspaces {
    margin: 5px 1px 6px 1px;
    padding: 0px 1px;
    border-radius: 15px;
    border: 0px;
    font-weight: bold;
    font-style: normal;
    font-size: 16px;
    color: @text-color;
}

#workspaces button {
    padding: 0px 5px;
    margin: 4px 3px;
    border-radius: 15px;
    border: 0px;
    color: @text-color;
    transition: all 0.3s ease-in-out;
}

#workspaces button.active {
    color: @text-color;
    background: @workspace-hover;
    border-radius: 15px;
    min-width: 40px;
    transition: all 0.3s ease-in-out;
}

#workspaces button:hover {
    color: @text-color;
    background: @workspace-hover;
    border-radius: 15px;
}

/* -----------------------------------------------------
 * Tooltips
 * ----------------------------------------------------- */

tooltip {
    border-radius: 10px;
    background-color: @text-color;
    opacity:0.8;
    padding:20px;
    margin:0px;
}

tooltip label {
    color: @background-modules;
}

/* -----------------------------------------------------
 * Window
 * ----------------------------------------------------- */

#window {
    background: @background-modules;
    margin: 10px 15px 10px 0px;
    padding: 2px 10px 0px 10px;
    border-radius: 12px;
    color:@text-color;
    font-size:16px;
    font-weight:normal;
}

window#waybar.empty #window {
    background-color:transparent;
}

/* -----------------------------------------------------
 * Taskbar
 * ----------------------------------------------------- */

#taskbar {
    background: @background-modules;
    margin: 6px 15px 6px 0px;
    padding:0px;
    border-radius: 15px;
    font-weight: normal;
    font-style: normal;
    border: 3px solid @background-modules;
}

#taskbar button {
    margin:0;
    border-radius: 15px;
    padding: 0px 5px 0px 5px;
}

/* -----------------------------------------------------
 * Modules
 * ----------------------------------------------------- */

.modules-left > widget:first-child > #workspaces {
    margin-left: 0;
}

.modules-right > widget:last-child > #workspaces {
    margin-right: 0;
}

/* -----------------------------------------------------
 * Custom Quicklinks
 * ----------------------------------------------------- */

#custom-browser, 
#custom-filemanager,
#network,
#pulseaudio,
#battery,
#custom-appmenu,
#clock {
    margin-right: 20px;
    font-size: 24px;
    font-weight: bold;
    color: @text-color;
    padding: 4px 10px 2px 10px;
}

#custom-quicklink1,
#custom-quicklink2,
#custom-quicklink3,
#custom-quicklink4,
#custom-quicklink5,
#custom-quicklink6,
#custom-quicklink7,
#custom-quicklink8,
#custom-quicklink9,
#custom-quicklink10 {
    padding:0px;
    margin-right: 7px;
    font-size:20px;
    color: @text-color;
}

/* -----------------------------------------------------
 * Custom Modules
 * ----------------------------------------------------- */

#custom-appmenu {
    background-color: @background-modules;
    color: @text-color;
    border-radius: 15px;
    margin: 10px 10px 10px 10px;
}

/* -----------------------------------------------------
 * Custom Exit
 * ----------------------------------------------------- */

#custom-exit {
    margin: 2px 20px 0px 0px;
    padding:0px;
    font-size:20px;
    color: @text-color;
}

/* -----------------------------------------------------
 * Hardware Group
 * ----------------------------------------------------- */

 #disk,#memory,#cpu,#language {
    background-color: @background-modules;
    margin:10px 7px 10px 0px;
    padding:0px;
    font-size:16px;
    border-radius: 15px;
    color:@text-color;
}

#language {
    margin-right:10px;
}

/* -----------------------------------------------------
 * Clock
 * ----------------------------------------------------- */

#clock {
    background-color: @background-modules;
    font-size: 21px;
    color: @text-color;
    border-radius: 15px;
    margin: 10px 7px 10px 0px;
}

/* -----------------------------------------------------
 * Pulseaudio
 * ----------------------------------------------------- */

#pulseaudio {
    background-color: @background-modules;
    font-size: 16px;
    color: @text-color;
    border-radius: 15px;
    margin: 10px 10px 10px 0px;
}

#pulseaudio.muted {
    background-color: @background-modules;
    color: @text-color;
}

/* -----------------------------------------------------
 * Network
 * ----------------------------------------------------- */

#network {
    background-color: @background-modules;
    font-size: 16px;
    color: @text-color;
    border-radius: 15px;
    margin: 10px 10px 10px 0px;
}

#network.ethernet {
    background-color: @background-modules;
    color: @text-color;
}

#network.wifi {
    background-color: @background-modules;
    color: @text-color;
}

/* -----------------------------------------------------
 * Bluetooth
 * ----------------------------------------------------- */

 #bluetooth, #bluetooth.on, #bluetooth.connected {
    background-color: @background-modules;
    font-size: 16px;
    color: @text-color;
    border-radius: 15px;
    margin: 10px 15px 10px 0px;
}

#bluetooth.off {
    background-color: transparent;
    padding: 0px;
    margin: 0px;
}

/* -----------------------------------------------------
 * Battery
 * ----------------------------------------------------- */

#battery {
    background-color: @background-modules;
    font-size: 16px;
    color: @text-color;
    border-radius: 15px;
    margin: 10px 15px 10px 0px;
}

#battery.charging, #battery.plugged {
    color: @text-color;
    background-color: @background-modules;
}

@keyframes blink {
    to {
        background-color: @background-modules;
        color: @text-color;
    }
}

#battery.critical:not(.charging) {
    background-color: #f53c3c;
    color: @text-color;
    animation-name: blink;
    animation-duration: 0.5s;
    animation-timing-function: linear;
    animation-iteration-count: infinite;
    animation-direction: alternate;
}

/* -----------------------------------------------------
 * Tray
 * ----------------------------------------------------- */

#tray {
    margin:0px 10px 0px 0px;
}

#tray > .passive {
    -gtk-icon-effect: dim;
}

#tray > .needs-attention {
    -gtk-icon-effect: highlight;
    background-color: #eb4d4b;
}

/* -----------------------------------------------------
 * Other
 * ----------------------------------------------------- */

label:focus {
    background-color: #000000;
}

#backlight {
    background-color: #90b1b1;
}

#network {
    background-color: #2980b9;
}

#network.disconnected {
    background-color: #f53c3c;
}


    '';



    home.file.".config/waybar/config.jsonc".text = ''

{
    // "layer": "top", // Waybar at top layer
    
    // "position": "bottom", // Waybar position (top|bottom|left|right)
    
    "height": 30, // Waybar height (to be removed for auto height)
    // "width": 1280, // Waybar width
    
    "spacing": 4, // Gaps between modules (4px)
    // Choose the order of the modules

    // Load Modules
    "include": [
        "~/.config/waybar/modules.json"
    ],    
    "modules-left": [
        "clock",
        "hyprland/workspaces",
    ],
    "modules-center": [
    ],
    "modules-right": [
        "mpd", 
        "pulseaudio", 
        "network", 
        "cpu",
        "disk",
        "memory", 
        "battery", 
        "tray",
    ]
}
    '';

    home.file.".config/waybar/modules.json".text =  ''

{
    // Workspaces
    "hyprland/workspaces" : {
        "on-click": "activate",
        "active-only": false,
        "all-outputs": true,
        "format": "{}",
        "format-icons": {
			"urgent": "",
			"active": "",
			"default": ""
        },
        "persistent-workspaces": {
             "*": 5
        }       
    },

    // Hyprland Window
    "hyprland/window": {
        "rewrite": {
            "(.*) - Brave": "$1",
            "(.*) - Chromium": "$1",
            "(.*) - Brave Search": "$1",
            "(.*) - Outlook": "$1",
            "(.*) Microsoft Teams": "$1"
        },
        "separate-outputs": true
    },

    // Rofi Application Launcher
    "custom/appmenu": {
        "format": "Apps",
        "tooltip-format": "Left: Open the application launcher\nRight: Show all keybindings",
        "on-click": "rofi -show drun -replace",
        "on-click-right": "~/.config/ml4w/scripts/keybindings.sh",
        "tooltip": false
    },
    
    // Power Menu
    "custom/exit": {
        "format": "",
        "tooltip-format": "Powermenu",
        "on-click": "wlogout -b 4",
        "tooltip": false
    },

    // Keyboard State
    "keyboard-state": {
        "numlock": true,
        "capslock": true,
        "format": "{name} {icon}",
        "format-icons": {
            "locked": "",
            "unlocked": ""
        }
    },

    // System tray
    "tray": {
        "icon-size": 23,
        "spacing": 10
    },

    // Clock
    "clock": {
        // "timezone": "America/New_York",
        "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
        "format-alt": "{:%Y-%m-%d}"
    },

    // System
    "custom/system": {
        "format": "",
        "tooltip": false
    },

    // CPU
    "cpu": {
        "interval": 5,
        "format": "󰻠 {usage}% ",
        "on-click": "alacritty -e htop"
    },

    // Memory
    "memory": {
        "interval": 5,
        "format": " {}% ",
        "on-click": "alacritty -e htop"
    },

    // Harddisc space used
    "disk": {
        "interval": 30,
        "format": " {percentage_used}% ",
        "path": "/",
        "on-click": "alacritty -e htop"
    }, 

    "hyprland/language": {
        "format": "/ K {short}"
    },

    // Group Hardware
    "group/hardware": {
        "orientation": "inherit",
        "drawer": {
            "transition-duration": 300,
            "children-class": "not-memory",
            "transition-left-to-right": false
        },        
        "modules": [
            "custom/system",
            "disk",
            "cpu",
            "memory",
            "hyprland/language"
        ]
    },
    
   // Network
    "network": {
        "format": "{ifname}",
        "format-wifi": "   {signalStrength}%",
        "format-ethernet": "  {ipaddr}",
        "format-disconnected": "Not connected", //An empty format will hide the module.
        "tooltip-format": " {ifname} via {gwaddri}",
        "tooltip-format-wifi": "   {essid} ({signalStrength}%)",
        "tooltip-format-ethernet": "  {ifname} ({ipaddr}/{cidr})",
        "tooltip-format-disconnected": "Disconnected",
        "max-length": 50,
        "on-click": "alacritty -e nmtui"
    },

    // Battery
    "battery": {
        "states": {
            // "good": 95,
            "warning": 30,
            "critical": 15
        },
        "format": "{icon}   {capacity}%",
        "format-charging": "  {capacity}%",
        "format-plugged": "  {capacity}%",
        "format-alt": "{icon}  {time}",
        // "format-good": "", // An empty format will hide the module
        // "format-full": "",
        "format-icons": [" ", " ", " ", " ", " "]
    },

    // Pulseaudio
    "pulseaudio": {
        // "scroll-step": 1, // %, can be a float
        "format": "{icon}  {volume}%",
        "format-bluetooth": "{volume}% {icon} {format_source}",
        "format-bluetooth-muted": " {icon} {format_source}",
        "format-muted": " {format_source}",
        "format-source": "{volume}% ",
        "format-source-muted": "",
        "format-icons": {
            "headphone": "",
            "hands-free": "",
            "headset": "",
            "phone": "",
            "portable": "",
            "car": "",
            "default": ["", " ", " "]
        },
        "on-click": "pavucontrol"
    },

    // Bluetooth
    "bluetooth": {
        "format-disabled": "",
        "format-off": "",
        "interval": 30,
        "on-click": "blueman-manager",
        "format-no-controller": ""
    },

    // Other
    "user": {
        "format": "{user}",
        "interval": 60,
        "icon": false,
    },

    // Idle Inhibator
    "idle_inhibitor": {
        "format": "{icon}",
        "tooltip": true,
        "format-icons":{
            "activated": "",
            "deactivated": ""
        },
        "on-click-right": "hyprlock"        
    }
}

    '';

    home.packages = with pkgs; [
        waybar
    ];

}
