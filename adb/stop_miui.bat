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
) do (
  @ECHO stop %%X
  adb shell appops set %%X RUN_IN_BACKGROUND deny
  adb shell appops set %%X START_FOREGROUND deny
  adb shell cmd netpolicy set restrict-background %%X true
  adb shell appops set %%X POST_NOTIFICATION deny
  adb shell am force-stop %%X
)
pause
