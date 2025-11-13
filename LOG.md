```bash
PS C:\worksapce\app> .\run-cordovabuilder.ps1
root@6b273cf84314:/workspace# ll /opt/app-env/
total 16
drwxr-xr-x 1 root root 4096 Nov 13 05:53 ./
drwxr-xr-x 1 root root 4096 Nov 13 05:53 ../
drwxr-xr-x 2 root root 4096 Nov 13 05:53 build-scripts/
drwxr-xr-x 2 root root 4096 Nov 12 10:06 platforms-files/
root@6b273cf84314:/workspace# ll /opt/app-env/build-scripts/
total 28
drwxr-xr-x 2 root root 4096 Nov 13 05:53 ./
drwxr-xr-x 1 root root 4096 Nov 13 05:53 ../
-rwxr-xr-x 1 root root 1810 Nov 13 05:49 apk-build-sign.sh*
-rwxr-xr-x 1 root root  441 Nov 13 05:50 apk-build.sh*
-rwxr-xr-x 1 root root 2608 Nov 13 05:49 apk-init.sh*
-rwxr-xr-x 1 root root  838 Nov 13 05:44 apk-replace-repositories.sh*
-rwxr-xr-x 1 root root 1437 Nov 13 05:50 apk-sign.sh*

root@6b273cf84314:/workspace# /opt/app-env/build-scripts/apk-init.sh 
------------------------------------------------------
🧩 Cordova Android Build Environment Check & Init
------------------------------------------------------
✅ JAVA_HOME = /opt/java/java
✅ ANDROID_SDK_ROOT = /opt/android-sdk
✅ GRADLE_HOME = /opt/gradle/gradle
✅ PATH = /opt/nodejs/node/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/gradle/gradle/bin:/opt/android-sdk/tools/bin:/opt/android-sdk/platform-tools:/opt/java/java/bin
------------------------------------------------------
🧩 检查必要命令...
✅ java = /opt/java/java/bin/java
✅ javac = /opt/java/java/bin/javac
✅ gradle = /opt/gradle/gradle/bin/gradle
✅ cordova = /opt/nodejs/node/bin/cordova
✅ /opt/android-sdk/cmdline-tools/latest/bin/sdkmanager = /opt/android-sdk/cmdline-tools/latest/bin/sdkmanager
------------------------------------------------------
✅ 环境变量与命令检测通过，准备构建
------------------------------------------------------
当前目录: /workspace
📦 安装 npm 依赖...
npm WARN app@1.2.3 No repository field.
npm WARN app@1.2.3 No license field.
npm WARN optional SKIPPING OPTIONAL DEPENDENCY: fsevents@2.3.2 (node_modules/fsevents):
npm WARN notsup SKIPPING OPTIONAL DEPENDENCY: Unsupported platform for fsevents@2.3.2: wanted {"os":"darwin","arch":"any"} (current: {"os":"linux","arch":"x64"})

added 497 packages from 275 contributors and audited 498 packages in 25.642s
found 75 vulnerabilities (3 low, 21 moderate, 37 high, 14 critical)
  run `npm audit fix` to fix them, or `npm audit` for details
(node:36) ExperimentalWarning: The fs.promises API is experimental
? May Cordova anonymously report usage statistics to improve the tool over time? Yes

Thanks for opting into telemetry to help us improve cordova.
10.0.0 (cordova-lib@10.1.0)
------------------------------------------------------
⚙️  准备 Cordova Android 平台...
(node:54) ExperimentalWarning: The fs.promises API is experimental
Using cordova-fetch for cordova-android@^9.1.0
Adding android project...
Creating Cordova project for the Android platform:
        Path: platforms/android
        Activity: MainActivity
        Android target: android-29
Subproject Path: CordovaLib
Subproject Path: app
Android project created with cordova-android@9.1.0
Discovered plugin "cordova-plugin-statusbar". Adding it to the project
Installing "cordova-plugin-statusbar" for android
Adding cordova-plugin-statusbar to package.json
Discovered plugin "cordova-plugin-splashscreen". Adding it to the project
Installing "cordova-plugin-splashscreen" for android
Adding cordova-plugin-splashscreen to package.json
Discovered plugin "cordova-plugin-globalization". Adding it to the project
Installing "cordova-plugin-globalization" for android
Adding cordova-plugin-globalization to package.json
Discovered plugin "cordova-plugin-screen-orientation". Adding it to the project
Installing "cordova-plugin-screen-orientation" for android
Installing "es6-promise-plugin" for android
Adding cordova-plugin-screen-orientation to package.json
Discovered plugin "cordova-plugin-whitelist". Adding it to the project
Installing "cordova-plugin-whitelist" for android
Adding cordova-plugin-whitelist to package.json
Discovered plugin "cordova-plugin-device". Adding it to the project
Installing "cordova-plugin-device" for android
Adding cordova-plugin-device to package.json
Discovered plugin "ionic-plugin-keyboard". Adding it to the project
Installing "ionic-plugin-keyboard" for android
Adding ionic-plugin-keyboard to package.json
Discovered plugin "cordova-plugin-geolocation". Adding it to the project
Installing "cordova-plugin-geolocation" for android
Adding cordova-plugin-geolocation to package.json
Discovered plugin "phonegap-plugin-barcodescanner". Adding it to the project
Installing "phonegap-plugin-barcodescanner" for android
Subproject Path: CordovaLib
Subproject Path: app
Adding phonegap-plugin-barcodescanner to package.json
Discovered plugin "cordova-plugin-app-version". Adding it to the project
Installing "cordova-plugin-app-version" for android
Adding cordova-plugin-app-version to package.json
Discovered plugin "cordova-plugin-file-transfer". Adding it to the project
Installing "cordova-plugin-file-transfer" for android
Installing "cordova-plugin-file" for android

The Android Persistent storage location now defaults to "Internal". Please check this plugin's README to see if your application needs any changes in its config.xml.

If this is a new application no changes are required.

If this is an update to an existing application that did not specify an "AndroidPersistentFileLocation" you may need to add:

      "<preference name="AndroidPersistentFileLocation" value="Compatibility" />"

to config.xml in order for the application to find previously stored files.

Adding cordova-plugin-file-transfer to package.json
Discovered plugin "cordova-plugin-file-opener2". Adding it to the project
Installing "cordova-plugin-file-opener2" for android
Subproject Path: CordovaLib
Subproject Path: app
Adding cordova-plugin-file-opener2 to package.json
Discovered plugin "cordova-plugin-inappbrowser". Adding it to the project
Installing "cordova-plugin-inappbrowser" for android
Adding cordova-plugin-inappbrowser to package.json

root@6b273cf84314:/workspace# /opt/app-env/build-scripts/apk-replace-repositories.sh 
🔄 开始替换仓库配置文件...
✅ 已更新 platforms/android/CordovaLib/cordova.gradle
✅ 已更新 platforms/android/repositories.gradle
✅ 已更新 platforms/android/CordovaLib/repositories.gradle
🎉 仓库配置文件替换完成
root@6b273cf84314:/workspace# /opt/app-env/build-scripts/apk-build-sign.sh
当前目录: /workspace
------------------------------------------------------
🏗️  正在构建 release APK（未签名）...
(node:518) ExperimentalWarning: The fs.promises API is experimental

12 errors, 0 warnings

Deprecated Gradle features were used in this build, making it incompatible with Gradle 7.0.
Use '--warning-mode all' to show the individual deprecation warnings.
See https://docs.gradle.org/6.5/userguide/command_line_interface.html#sec:command_line_warnings

BUILD SUCCESSFUL in 1m 29s
43 actionable tasks: 43 executed
Built the following apk(s): 
        /workspace/platforms/android/app/build/outputs/apk/release/app-release-unsigned.apk
------------------------------------------------------
📦 构建 APK 完成
------------------------------------------------------
🔑 签名 APK...
🔑 检查环境变量...
✅ 未签名 APK 路径: ./platforms/android/app/build/outputs/apk/release/app-release-unsigned.apk

  signing: res/xml/config.xml
  signing: res/xml/opener_paths.xml
  signing: res/xml/preferences.xml

Warning:
The signer's certificate is self-signed.
------------------------------------------------------
🎉 APK 签名流程完成

```