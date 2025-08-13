# 万象熄屏
com.miui.aod
# 停用广告模块
com.miui.analytics
# 停用广告模块
com.miui.systemAdSolution
# 停用广告模块
com.xiaomi.ab
# 停用收音机
com.miui.fmservice
# 停用HTML查看器
com.android.htmlviewer
# 停用快应用
com.miui.hybrid.accessory
# 停用快应用
com.miui.hybrid
# 停用用户反馈
com.miui.bugreport
# 停用服务和反馈
com.miui.miservice
# 停用浏览器
com.android.browser
# 停用搜索
com.android.quicksearchbox
# 停用视频
com.miui.video
# 停用音乐
com.miui.player
# 停用游戏中心
com.xiaomi.migameservice
com.xiaomi.gamecenter.sdk.service
# 停用miui+ 万物互联
com.xiaomi.mirror
# 停用 智能助理
com.miui.personalassistant 
#
# 停用应用商店
# com.xiaomi.market
# 停用系统更新
# com.android.updater
# 停用电子邮件
# com.android.email
# 停用小米钱包、支付
# com.xiaomi.miplay_client
# com.mipay.wallet
# 悬浮球
com.miui.touchassistant
#MIUI to MIUI Message
com.xiaomi.mircs
#常用语
com.miui.phrase
# 生活黄页
com.miui.yellowpage
# 音质增强
com.miui.misound
# 小米无障碍
com.miui.accessibility



# 停用搜狗输入法
# com.sohu.inputmethod.sogou.xiaomi

# 停用【谷歌全家桶】 按任意键继续…
com.google.android.ext.services
com.google.android.marvin.talkback






# 允许应用在后台运行（禁用后台限制）
adb shell cmd appops set com.xiaomi.mibrain.speech RUN_IN_BACKGROUND allow

# 允许应用忽略电池优化（关键步骤）
adb shell dumpsys deviceidle whitelist +com.xiaomi.mibrain.speech

# 设置应用后台进程限制为"无限制"（小米特有策略）
adb shell am set-standby-bucket com.xiaomi.mibrain.speech active
