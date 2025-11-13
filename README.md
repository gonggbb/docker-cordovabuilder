# Cordova10 混合 App 构建环境

## 📚 答疑建议

- 📦 Github 项目仓库 [docker-cordovabuilder](https://github.com/gonggbb/docker-cordovabuilder.git)
- `LOG.md` 构建流程日志
- env_zip 压缩包自己下载

## 🛠 环境配置

| 组件                | 版本          | 备注                       |
| ------------------- | ------------- | -------------------------- |
| **Java**            | `1.8`         |                            |
| **Gradle**          | `6.5-all`     |                            |
| **SDK**             | `30` (30.0.3) |                            |
| **Node.js**         | `10.15.3`     |                            |
| **Cordova**         | `10`          |                            |
| **cordova-android** | `^9.1.0`      | 需要 `gradle 6.5-all` 版本 |

## ▶️ Windows 启动脚本

手动创建，powershell启动【不是cmd】 [run-cordovabuilder.ps1](/worksapce/run-cordovabuilder.ps1)

```powershell

param(
    [string]$ProjectPath = "C:\worksapce\项目目录",
    [string]$GradleCachePath = "C:\worksapce\项目目录\gradle-caches"
)

docker run -it `
  -v ${ProjectPath}:/workspace `
  -v ${GradleCachePath}:/root/.gradle `
  -u 0 `
  -e KEYSTORE_PATH=/workspace/xx.keystore `
  -e KEY_ALIAS=xx`
  -e KEYSTORE_PASSWORD=自己的密码 `
  -e KEY_PASSWORD=自己的密码 `
  gamesg/cordovabuilder:v1.0.0-rc.4.1 bash -c "
    ln -s /opt/app-env/build-scripts /workspace/build-scripts-short &&
    exec /bin/bash
```

## ⚠️ 注意事项

### `cordova-fetch for cordova-android`

```bash
Thanks for opting into telemetry to help us improve cordova.
10.0.0 (cordova-lib@10.1.0)
------------------------------------------------------
⚙️  准备 Cordova Android 平台...
(node:54) ExperimentalWarning: The fs.promises API is experimental
Using cordova-fetch for cordova-android@^9.1.0

```

<div style="border: 2px solid #FF5733; border-radius: 5px; padding: 10px; margin: 10px 0;">
  <p>⚠️ 注意：`cordova platform add android@10.0.0` 会下载 `gradle 7.x` 【不支持】</p>
</div>

<div style="border: 2px solid #FF5733; border-radius: 5px; padding: 10px; margin: 10px 0;">
  <p>⚠️ 注意：gradle 6.5-all 首次构建 `cordova build android` 会下载 【distributionUrl=https://services.gradle.org/distributions/gradle-6.5-all.zip】</p>
</div>

## 📦 版本说明

### 🔄 <span style="color: #4CAF50">v1.0.0-rc.4.1</span>

- 包含 v1.0.0-rc.4 feat:1 ; v1.0.0-rc.4 feat:2

- feat:1 gradle-6.5-all.zip\*下载失败手动替换 `/root/.gradle/wrapper/dists/gradle-6.5-all/2oz4ud9k3tuxjg84bbf55q0tn/gradle-6.5-all.zip`

> 2oz4ud9k3tuxjg84bbf55q0tn 随机的

```bash
root@73578b1a6311:/# ll /root/.gradle/wrapper/dists/gradle-6.5-all/2oz4ud9k3tuxjg84bbf55q0tn/
total 142352
drwxr-xr-x 1 root root      4096 Nov 13 06:35 ./
drwxr-xr-x 1 root root      4096 Nov 13 06:34 ../
drwxr-xr-x 1 root root      4096 Nov 13 06:35 gradle-6.5/
-rw-r--r-- 1 root root 145767155 Nov 13 06:34 gradle-6.5-all.zip
-rw-r--r-- 1 root root         0 Nov 13 06:34 gradle-6.5-all.zip.lck
-rw-r--r-- 1 root root         0 Nov 13 06:35 gradle-6.5-all.zip.ok

```

### 🔄 v1.0.0-rc.4

- feat:1 `v1.0.0-rc.1 fix:1.1` apk-replace-repositories.sh 替换`jcenter`依赖

```bash
drwxr-xr-x 1 root root      4096 Nov 13 06:56 build-scripts/
-rwxr-xr-x 1 root root 145767155 Nov 12 01:33 gradle-6.5-all.zip*
drwxr-xr-x 2 root root      4096 Nov 12 10:06 platforms-files/
```

- feat:2 添加 `gradle-caches.tar.gz` 缓存文件，优化构建速度

  启动的时候 gradle-caches 镜像挂载的目录 `C:\worksapce\项目目录\gradle-caches:/root/.gradle`

  挂载参数:

  ```bash
  -v ${GradleCachePath}:/root/.gradle `
  -u 0 `
  ```

  tar -xzf /workspace/gradle-caches.tar.gz -C /workspace

```bash
drwxr-xr-x 1 root root      4096 Nov 13 06:35 gradle-caches/
```

- feat:3：添加 `build-scripts` 软链接，打包脚本会自动创建软链接

```bash
  rwxr-xr-x 1 root root 2608 Nov 13 05:49 apk-init.sh*                  # 初始化环境
  rwxr-xr-x 1 root root  838 Nov 13 05:44 apk-replace-repositories.sh*  # 替换jcenter依赖
  rwxr-xr-x 1 root root 1810 Nov 13 05:49 apk-build-sign.sh*            # 打包签名
  rwxr-xr-x 1 root root  441 Nov 13 05:50 apk-build.sh*                 # 打包
  rwxr-xr-x 1 root root 1437 Nov 13 05:50 apk-sign.sh*                  # 签名
  rwxrwxrwx 1 root root   26 Nov 13 06:56 build-scripts -> /opt/app-env/build-scripts/
```

### 🔄 <span style="color: #4CAF50">v1.0.0-rc.3</span>

- 修复 `v1.0.0-rc.1 fix:1.0` 需要进入手动容器设置 GRADLE_HOME

### 🔄 v1.0.0-rc.1（初始版本）

#### 修复内容

- `fix:1.0` 需要进入容器设置 `export GRADLE_HOME=/opt/gradle/gradle`
- `fix:1.1` `jcenter` 依赖替换

> `platforms/android/CordovaLib/cordova.gradle` > `platforms/android/CordovaLib/repositories.gradle` > `platforms/android/repositories.gradle`

- `platforms\android\CordovaLib\cordova.gradle`

```bash
buildscript {
    repositories {
      maven { url 'https://maven.aliyun.com/repository/central' }
      maven { url 'https://maven.aliyun.com/repository/jcenter' }
      maven { url 'https://maven.aliyun.com/repository/public' }
      maven { url 'https://maven.aliyun.com/repository/google' }
      google()
      mavenCentral()
    //   maven { url 'https://jitpack.io' }
    //   maven { url "https://plugins.gradle.org/m2/" }
    //   maven { url uri('../local-m2') }
    //   jcenter()
    }

    dependencies {
        // classpath 'libs/gradle-bintray-plugin-1.7.3.jar'
        // classpath 'com.g00fy2:versioncompare:1.3.4@jar'
        classpath 'io.github.g00fy2:versioncompare:1.4.0@jar'

    }
}
```

- `platforms\android\CordovaLib\repositories.gradle`

```bash

ext.repos = {
     maven { url 'https://maven.aliyun.com/repository/central' }
      maven { url 'https://maven.aliyun.com/repository/jcenter' }
      maven { url 'https://maven.aliyun.com/repository/public' }
      maven { url 'https://maven.aliyun.com/repository/google' }
      google()
      mavenCentral()
}

```

- `platforms\android\repositories.gradle`

```bash

ext.repos = {
    // google()
    // jcenter()
      maven { url 'https://maven.aliyun.com/repository/central' }
      maven { url 'https://maven.aliyun.com/repository/jcenter' }
      maven { url 'https://maven.aliyun.com/repository/public' }
      maven { url 'https://maven.aliyun.com/repository/google' }
      google()
      mavenCentral()
}

```
