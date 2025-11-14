FROM ubuntu:18.04


# 设置环境变量（修改 JAVA_HOME 指向自定义安装路径）
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    JAVA_HOME=/opt/java/java \
    ANDROID_HOME=/opt/android-sdk \
    ANDROID_SDK_ROOT=/opt/android-sdk \
    GRADLE_HOME=/opt/gradle/gradle \
    ANDROID_BUILD_TOOLS=/opt/android-sdk/build-tools/30.0.3 \
    # GRADLE_USER_HOME=/opt/gradle/gradle \
    PATH=$PATH:/opt/gradle/gradle/bin:/opt/android-sdk/tools/bin:/opt/android-sdk/platform-tools:/opt/java/java/bin:/opt/android-sdk/build-tools/30.0.3
# 替换现有的错误安装命令
RUN apt-get update && \
    apt-get install -y \
    unzip \
    xz-utils \
    && apt-get clean && \
    rm -rf /var/lib/apt/lists/*


# 创建必要的目录并设置权限
RUN mkdir -p /opt/android-sdk /opt/gradle /opt/nodejs /opt/java && \
    chmod -R 755 /opt/android-sdk

# 替代 apt-get 安装 Java 的方式 /opt/java/java
COPY env_zip/jdk-8u202-linux-x64.tar.gz /opt/java/
RUN cd /opt/java && \
    tar -xzf jdk-8u202-linux-x64.tar.gz && \
    mv jdk1.8.0_202 java && \
    rm jdk-8u202-linux-x64.tar.gz

# 将原有的 Node.js 下载安装替换为：/opt/nodejs/node
COPY env_zip/node-v10.15.3-linux-x64.tar.xz /opt/nodejs/
RUN cd /opt/nodejs && \
    tar -xJf node-v10.15.3-linux-x64.tar.xz && \
    mv node-v10.15.3-linux-x64 node && \
    rm node-v10.15.3-linux-x64.tar.xz

# 设置 Node.js 环境变量
ENV PATH=/opt/nodejs/node/bin:$PATH


# ✅ 安装 Android cmdline-tools（兼容新版结构）
COPY env_zip/commandlinetools-linux-6609375_latest.zip /opt/android-sdk/cmdline-tools-tmp.zip
RUN cd /opt/android-sdk && \
    unzip -q cmdline-tools-tmp.zip && \
    mkdir -p /opt/android-sdk/cmdline-tools/latest && \
    mv /opt/android-sdk/tools/* /opt/android-sdk/cmdline-tools/latest/  && \
    rm -rf cmdline-tools-tmp.zip 

# 接受 SDK 许可证
RUN yes | /opt/android-sdk/cmdline-tools/latest/bin/sdkmanager --sdk_root=/opt/android-sdk --licenses


# 安装 Android SDK 平台和构建工具
RUN /opt/android-sdk/cmdline-tools/latest/bin/sdkmanager \
    "platform-tools" \
    "platforms;android-30" \
    "build-tools;30.0.3" \
    "extras;android;m2repository" \
    "extras;google;m2repository"

# 安装 Gradle 6.5

COPY env_zip/gradle-6.5-all.zip /opt/gradle/
RUN cd /opt/gradle && \
    unzip -q gradle-6.5-all.zip && \
    mv gradle-6.5 gradle && \
    rm gradle-6.5-all.zip

# 安装 Cordova
RUN npm install -g cordova@10.0.0

# 创建工作目录
WORKDIR /workspace

# 只复制存在的文件/目录
COPY *.sh /opt/app-env/build-scripts/
COPY platforms-files /opt/app-env/platforms-files
COPY env_zip/gradle-6.5-all.zip /opt/app-env/

# 验证安装

RUN node --version && \
    npm --version && \
    java -version && \
    /opt/gradle/gradle/bin/gradle --version && \
    cordova --version

CMD ["/bin/bash"]