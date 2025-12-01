adb devices

for %%X in (
  "io.legado.app.release"
  "com.xiaomi.mibrain.speech"
) do (
  @ECHO allow %%X

  adb shell appops set %%X RUN_IN_BACKGROUND allow
  adb shell appops set %%X START_FOREGROUND allow
  adb shell dumpsys deviceidle whitelist +%%X
  adb shell cmd netpolicy set restrict-background %%X false
  adb shell appops set %%X POST_NOTIFICATION allow
  adb shell cmd power put-into-battery-saver %%X false
  adb shell cmd package set-importance %%X 100
  adb shell am set-standby-bucket %%X active
)
