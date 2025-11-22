{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.modules.hyprsunset.enable = lib.mkEnableOption "";

  config = lib.mkIf config.modules.hyprsunset.enable {
    services.hyprsunset = {
      enable = true;
      transitions = {
        t0700 = { calendar = "*-*-* 07:00:00"; requests = [[ "temperature" "6500" ]]; };
        t0730 = { calendar = "*-*-* 07:30:00"; requests = [[ "temperature" "6500" ]]; };
        t0800 = { calendar = "*-*-* 08:00:00"; requests = [[ "temperature" "6500" ]]; };
        t0830 = { calendar = "*-*-* 08:30:00"; requests = [[ "temperature" "6500" ]]; };
        t0900 = { calendar = "*-*-* 09:00:00"; requests = [[ "temperature" "6500" ]]; };
        t0930 = { calendar = "*-*-* 09:30:00"; requests = [[ "temperature" "6500" ]]; };
        t1000 = { calendar = "*-*-* 10:00:00"; requests = [[ "temperature" "6500" ]]; };
        t1030 = { calendar = "*-*-* 10:30:00"; requests = [[ "temperature" "6500" ]]; };
        t1100 = { calendar = "*-*-* 11:00:00"; requests = [[ "temperature" "6500" ]]; };
        t1130 = { calendar = "*-*-* 11:30:00"; requests = [[ "temperature" "6500" ]]; };
        t1200 = { calendar = "*-*-* 12:00:00"; requests = [[ "temperature" "6500" ]]; };
        t1230 = { calendar = "*-*-* 12:30:00"; requests = [[ "temperature" "6500" ]]; };
        t1300 = { calendar = "*-*-* 13:00:00"; requests = [[ "temperature" "6500" ]]; };
        t1330 = { calendar = "*-*-* 13:30:00"; requests = [[ "temperature" "6500" ]]; };
        t1400 = { calendar = "*-*-* 14:00:00"; requests = [[ "temperature" "6500" ]]; };
        t1430 = { calendar = "*-*-* 14:30:00"; requests = [[ "temperature" "6500" ]]; };
        t1500 = { calendar = "*-*-* 15:00:00"; requests = [[ "temperature" "6500" ]]; };
        t1530 = { calendar = "*-*-* 15:30:00"; requests = [[ "temperature" "6500" ]]; };
        t1600 = { calendar = "*-*-* 16:00:00"; requests = [[ "temperature" "6500" ]]; };
        t1630 = { calendar = "*-*-* 16:30:00"; requests = [[ "temperature" "6500" ]]; };

        # 100 Steps
        t1700 = { calendar = "*-*-* 17:00:00"; requests = [[ "temperature" "5000" ]]; }; # 5000K @ 5PM
        t1730 = { calendar = "*-*-* 17:30:00"; requests = [[ "temperature" "4900" ]]; };
        t1800 = { calendar = "*-*-* 18:00:00"; requests = [[ "temperature" "4800" ]]; };
        t1830 = { calendar = "*-*-* 18:30:00"; requests = [[ "temperature" "4700" ]]; };
        t1900 = { calendar = "*-*-* 19:00:00"; requests = [[ "temperature" "4600" ]]; };
        t1930 = { calendar = "*-*-* 19:30:00"; requests = [[ "temperature" "4500" ]]; };
        t2000 = { calendar = "*-*-* 20:00:00"; requests = [[ "temperature" "4400" ]]; };
        t2030 = { calendar = "*-*-* 20:30:00"; requests = [[ "temperature" "4300" ]]; };
        t2100 = { calendar = "*-*-* 21:00:00"; requests = [[ "temperature" "4200" ]]; };
        t2130 = { calendar = "*-*-* 21:30:00"; requests = [[ "temperature" "4100" ]]; };
        t2200 = { calendar = "*-*-* 22:00:00"; requests = [[ "temperature" "4000" ]]; }; # 4000K @ 10PM

        # 250 Steps
        t2230 = { calendar = "*-*-* 22:30:00"; requests = [[ "temperature" "3250" ]]; };
        t2300 = { calendar = "*-*-* 23:00:00"; requests = [[ "temperature" "3000" ]]; }; # 3000K @ 11PM
        t2330 = { calendar = "*-*-* 23:30:00"; requests = [[ "temperature" "2750" ]]; };
        t0000 = { calendar = "*-*-* 00:00:00"; requests = [[ "temperature" "2500" ]]; }; # 2500K @ 12AM

        t0030 = { calendar = "*-*-* 00:30:00"; requests = [[ "temperature" "2500" ]]; };
        t0100 = { calendar = "*-*-* 01:00:00"; requests = [[ "temperature" "2500" ]]; };
        t0130 = { calendar = "*-*-* 01:30:00"; requests = [[ "temperature" "2500" ]]; };
        t0200 = { calendar = "*-*-* 02:00:00"; requests = [[ "temperature" "2500" ]]; };
        t0230 = { calendar = "*-*-* 02:30:00"; requests = [[ "temperature" "2500" ]]; };
        t0300 = { calendar = "*-*-* 03:00:00"; requests = [[ "temperature" "2500" ]]; };
        t0330 = { calendar = "*-*-* 03:30:00"; requests = [[ "temperature" "2500" ]]; };
        t0400 = { calendar = "*-*-* 04:00:00"; requests = [[ "temperature" "2500" ]]; };
        t0430 = { calendar = "*-*-* 04:30:00"; requests = [[ "temperature" "2500" ]]; };
        t0500 = { calendar = "*-*-* 05:00:00"; requests = [[ "temperature" "2500" ]]; };
        t0530 = { calendar = "*-*-* 05:30:00"; requests = [[ "temperature" "2500" ]]; };
        t0600 = { calendar = "*-*-* 06:00:00"; requests = [[ "temperature" "2500" ]]; };
        t0630 = { calendar = "*-*-* 06:30:00"; requests = [[ "temperature" "2500" ]]; };

      };
    };
  };
}