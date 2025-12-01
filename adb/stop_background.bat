adb devices

for %%X in (
 "com.miui.systemAdSolution"
 "com.xiaomi.aireco"
 "com.xiaomi.barrage"
 "com.xiaomi.mirror"
 "com.xiaomi.joyose"
 "com.xiaomi.migameservice"
 "com.miui.carlink"
 "com.miui.video"
 "com.miui.vipservice"
 "com.miui.analytics"
 "com.miui.bugreport"
 "com.miui.player"
 "com.miui.yellowpage"
 "com.miui.hybrid"
 "com.miui.hybrid.accessory"
 "com.android.wallpaper.livepicker"
 "com.android.wallpaperpicker"
 "com.android.thememanager"
 "com.android.htmlviewer"
 "com.android.printspooler"
 "com.android.bips"
 "com.android.browser"
 "com.milink.service"
 "com.xiaomi.ab"
) do (
  @ECHO stop %%X

  adb shell appops set %%X RUN_IN_BACKGROUND deny
  adb shell appops set %%X START_FOREGROUND deny
  adb shell dumpsys deviceidle whitelist -%%X
  adb shell cmd netpolicy set restrict-background %%X true
  adb shell appops set %%X POST_NOTIFICATION deny
  adb shell cmd power put-into-battery-saver %%X true
  adb shell cmd package set-importance %%X 0
  adb shell am set-standby-bucket %%X deep
  adb shell am force-stop %%X
)
pause
