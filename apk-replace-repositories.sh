#!/bin/bash
echo "🔄 开始替换仓库配置文件..."

# 确保目标目录存在
mkdir -p "platforms/android/CordovaLib"

# 替换文件
if [ -f "/opt/app-env/platforms-files/cordova.gradle" ]; then
    cp "/opt/app-env/platforms-files/cordova.gradle" "platforms/android/CordovaLib/cordova.gradle"
    echo "✅ 已更新 platforms/android/CordovaLib/cordova.gradle"
fi

if [ -f "/opt/app-env/platforms-files/repositories.gradle" ]; then
    cp "/opt/app-env/platforms-files/repositories.gradle" "platforms/android/repositories.gradle"
    echo "✅ 已更新 platforms/android/repositories.gradle"
    
    cp "/opt/app-env/platforms-files/repositories.gradle" "platforms/android/CordovaLib/repositories.gradle"
    echo "✅ 已更新 platforms/android/CordovaLib/repositories.gradle"
fi

echo "🎉 仓库配置文件替换完成"