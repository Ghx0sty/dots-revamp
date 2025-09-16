{
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      "$terminal" = "alacritty";
      "$launcher-kill" = "pkill rofi";
      "$launcher-start" = "zsh ../../../.config/rofi/scripts/launcher_t6";
      "$browser" = "librewolf";

      "$mainmod" = "ALT";
      "$secondmod" = "SUPER";
      monitor = [
        "Virtual-1,1920x1080@60,0x0,1"
      ];
      bind = [
        "$mainmod, q, exec, $terminal"
        "$secondmod, b, exec, $browser"
        "$mainmod, c, killactive"
        "$mainmod, m, exit"

        "$mainmod, left, movefocus, l"
        "$mainmod, right, movefocus, r"
        "$mainmod, up, movefocus, u"
        "$mainmod, down, movefocus, d"

        "$secondmod, left, movewindow, l"
        "$secondmod, right, movewindow, r"
        "$secondmod, up, movewindow, u"
        "$secondmod, down, movewindow, d"

        "CTRL ALT, right, workspace, r+1"
        "CTRL ALT, left, workspace, r-1"

        "$secondmod, 1, workspace, 1"
        "$secondmod, 2, workspace, 2"
        "$secondmod, 3, workspace, 3"
        "$secondmod, 4, workspace, 4"
        "$secondmod, 5, workspace, 5"
      ];
      bindr = [
        "SUPER, SUPER_L, exec, $launcher-start || $launcher-kill"
      ];
    };
  };
}
