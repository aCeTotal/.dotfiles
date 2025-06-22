{ config, pkgs, ... }:

{

     home.packages = with pkgs; [
        nerd-fonts.caskaydia-cove
        font-awesome
        waybar
    ];


    home.file.".config/waybar/style.css".text = ''

* {
  font-family: "CaskaydiaCove Nerd Font", "Font Awesome 6 Free", "Font Awesome 6 Free Solid";
  font-weight: bold;
  font-size: 16px;
  color: #dcdfe1;
}

#waybar {
  background-color: rgba(0, 0, 0, 0);
  border: none;
  box-shadow: none;
}

#workspaces,
#window,
#tray{
  /*background-color: rgba(29,31,46, 0.95);*/
  background-color: rgba(15,27,53,0.9);
  padding: 4px 6px; /* 保持内部间距 */
  margin-top: 6px; /* 外部间距增加 */
  margin-left: 6px; /* 外部间距增加 */
  margin-right: 6px; /* 外部间距增加 */
  border-radius: 10px;
  border-width: 0px;
}

#clock,
#custom-power{
  background-color: rgba(15,27,53,0.9);
  margin-top: 6px; /* 与屏幕顶部留出距离 */
  margin-right: 6px;
  /*margin-bottom: 4px;*/
  padding: 4px 2px; /* 保持内部间距 */
  border-radius: 0 10px 10px 0;
  border-width: 0px;
}

#network,
#custom-lock{
  background-color: rgba(15,27,53,0.9);
  margin-top: 6px; /* 与屏幕顶部留出距离 */
  margin-left: 6px;
  /*margin-bottom: 4px;*/
  padding: 4px 2px; /* 保持内部间距 */
  border-radius: 10px 0 0 10px;
  border-width: 0px;
}

#custom-reboot,
#bluetooth,
#battery,
#pulseaudio,
#backlight,
#custom-temperature,
#memory,
#cpu{
  background-color: rgba(15,27,53,0.9);
  margin-top: 6px; /* 与屏幕顶部留出距离 */
  /*margin-bottom: 4px;*/
  padding: 4px 2px; /* 保持内部间距 */
  border-width: 0px;
}

#custpm-temperature.critical,
#pulseaudio.muted {
  color: #FF0000;
  padding-top: 0;
}

/* 鼠标悬停变亮一点 */
#bluetooth:hover,
#network:hover,
/*#tray:hover,*/
#backlight:hover,
#battery:hover,
#pulseaudio:hover,
#custom-temperature:hover,
#memory:hover,
#cpu:hover,
#clock:hover,
#custom-lock:hover,
#custom-reboot:hover,
#custom-power:hover,
/*#workspaces:hover,*/
#window:hover {
  background-color: rgba(70, 75, 90, 0.9);
}

/* 工作区激活状态高亮 */
#workspaces button:hover{
  background-color: rgba(97, 175, 239, 0.2);
  padding: 2px 8px;
  margin: 0 2px;
  border-radius: 10px;
}

#workspaces button.active {
  background-color: #61afef; /* 蓝色高亮 */
  color: #ffffff;
  padding: 2px 8px;
  margin: 0 2px;
  border-radius: 10px;
}

/* 未激活工作区按钮 */
#workspaces button {
  background: transparent;
  border: none;
  color: #888888;
  padding: 2px 8px;
  margin: 0 2px;
  font-weight: bold;
}

#window {
  font-weight: 500;
  font-style: italic;
}


    '';



    home.file.".config/waybar/config.jsonc".text = ''

{
  "layer": "top",
  "position": "top",
  "height": 32,
  "spacing": 0,
  "modules-left": [
    "hyprland/workspaces",
    "tray",
    "custom/lock",
    "custom/reboot",
    "custom/power"
  ],
  "modules-center": ["hyprland/window"],
  "modules-right": [
    "network",
    "battery",
    "bluetooth",
    "pulseaudio",
    "backlight",
    "custom/temperature",
    "memory",
    "cpu",
    "clock"
  ],
  "hyprland/workspaces": {
    "disable-scroll": false,
    "all-outputs": true,
    "format": "{icon}",
    "on-click": "activate",
    "persistent-workspaces": {
    "*":[1,2,3,4,5,6,7,8,9]
    },
    "format-icons": {
      "1": "󰣇",
      "2": "󰈹",
      "3": "󰇮",
      "4": "",
      "5": "",
      "6": "",
      "7": "",
      "8": "",
      "9": "󰖳",
      "default": ""
    }
  },
  "custom/lock": {
  "format": "<span color='#00FFFF'>  </span>",
  "on-click": "hyprlock",
  "tooltip": true,
  "tooltip-format": "Lock your screen"
  },
  "custom/reboot": {
    "format": "<span color='#FFD700'>  </span>",
    "on-click": "systemctl reboot",
    "tooltip": true,
    "tooltip-format": "Reboot the system"
  },
  "custom/power": {
    "format": "<span color='#FF4040'>  </span>",
    "on-click": "systemctl poweroff",
    "tooltip": true,
    "tooltip-format": "Turn off the system"
  },
  "network": {
    "format-wifi": "<span color='#00FFFF'> 󰤨 </span>{essid} ",
    "format-ethernet": "<span color='#7FFF00'> </span>Wired ",
    "tooltip-format": "<span color='#FF1493'> 󰅧 </span>{bandwidthUpBytes}  <span color='#00BFFF'> 󰅢 </span>{bandwidthDownBytes}",
    "format-linked": "<span color='#FFA500'> 󱘖 </span>{ifname} (No IP) ",
    "format-disconnected": "<span color='#FF4040'>  </span>Disconnected ",
    "format-alt": "<span color='#00FFFF'> 󰤨 </span>{signalStrength}% ",
    "interval": 1
  },
  "battery": {
    "states": {
      "warning": 30,
      "critical": 15
    },
    "format": "<span color='#28CD41'> {icon} </span>{capacity}% ",
    "format-charging": " 󱐋{capacity}%",
	  "interval": 1,
    "format-icons": ["󰂎", "󰁼", "󰁿", "󰂁", "󰁹"],
    "tooltip": true
  },
  "pulseaudio": {
    "format": "<span color='#00FF7F'>{icon}</span>{volume}% ",
    "format-muted": "<span color='#FF4040'> 󰖁 </span>0% ",
    "format-icons": {
      "headphone": "<span color='#BF00FF'>  </span>",
      "hands-free": "<span color='#BF00FF'>  </span>",
      "headset": "<span color='#BF00FF'>  </span>",
      "phone": "<span color='#00FFFF'>  </span>",
      "portable": "<span color='#00FFFF'>  </span>",
      "car": "<span color='#FFA500'>  </span>",
      "default": [
        "<span color='#808080'>  </span>",
        "<span color='#FFFF66'>  </span>",
        "<span color='#00FF7F'>  </span>"
      ]
    },
    "on-click-right": "pavucontrol -t 3",
    "on-click": "pactl -- set-sink-mute 0 toggle",
    "tooltip": true,
    "tooltip-format": "当前系统声音: {volume}%"
  },
  "custom/temperature": {
    "exec": "sensors | awk '/^Package id 0:/ {print int($4)}'",
    "format": "<span color='#FFA500'> </span>{}°C ",
    "interval": 5,
    "tooltip": true,
    "tooltip-format": "当前 CPU 温度: {}°C"
  },
  "memory": {
    "format": "<span color='#8A2BE2'>  </span>{used:0.1f}G/{total:0.1f}G ",
    "tooltip": true,
    "tooltip-format": "当前内存占比: {used:0.2f}G/{total:0.2f}G"
  },
  "cpu": {
    "format": "<span color='#FF9F0A'>  </span>{usage}% ",
    "tooltip": true
  },
  "clock": {
    "interval": 1,
    "timezone": "Asia/Chengdu",
    "format": "<span color='#BF00FF'>  </span>{:%H:%M} ",
    "tooltip": true,
    "tooltip-format": "{:L%Y 年 %m 月 %d 日, %A}"
  },
  "tray": {
    "icon-size": 17,
    "spacing": 6
  },
  "backlight": {
    "device": "intel_backlight",
    "format": "<span color='#FFD700'>{icon}</span>{percent}% ",
    "tooltip": true,
    "tooltip-format": "当前屏幕亮度: {percent}%",
    "format-icons": [
      "<span color='#696969'> 󰃞 </span>",  // 暗 - 深灰
      "<span color='#A9A9A9'> 󰃝 </span>",  // 中 - 灰
      "<span color='#FFFF66'> 󰃟 </span>",  // 亮 - 柠檬黄
      "<span color='#FFD700'> 󰃠 </span>"   // 最亮 - 金色
    ]
  },
  "bluetooth": {
    "format": "<span color='#00BFFF'>  </span>{status} ",
    "format-connected": "<span color='#00BFFF'>  </span>{device_alias} ",
    "format-connected-battery": "<span color='#00BFFF'>  </span>{device_alias}{device_battery_percentage}% ",
    "tooltip-format": "{controller_alias}\t{controller_address}\n\n{num_connections} connected",
    "tooltip-format-connected": "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}",
    "tooltip-format-enumerate-connected": "{device_alias}\t{device_address}",
    "tooltip-format-enumerate-connected-battery": "{device_alias}\t{device_address}\t{device_battery_percentage}%"
  }
}


    '';

}
