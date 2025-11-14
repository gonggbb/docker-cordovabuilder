#!/bin/bash
# 检查变量
echo "🔑 检查环境变量..."
if [ -z "$KEYSTORE_PATH" ] || [ -z "$KEY_ALIAS" ] || [ -z "$KEYSTORE_PASSWORD" ] || [ -z "$KEY_PASSWORD" ]; then  echo "❌ 签名所需的环境变量未全部设置。请确保以下变量已设置："
  echo "   KEYSTORE_PATH, KEY_ALIAS, KEYSTORE_PASSWORD, KEY_PASSWORD"
  echo "------------------------------------------------------"
  exit 1
fi

# 进入项目目录
PROJECT_DIR=${PROJECT_DIR:-/workspace}
cd "$PROJECT_DIR" || { echo "❌ 项目目录不存在: $PROJECT_DIR"; exit 1; }
echo "当前目录: $(pwd)"


# 编辑 ~/.bashrc 文件
# export ANDROID_BUILD_TOOLS=/opt/android-sdk/build-tools/30.0.3
# export PATH=$PATH:$ANDROID_BUILD_TOOLS

apksigner --version

echo $ANDROID_BUILD_TOOLS

echo "🧩 使用 apksigner 进行 APK 签名..."

# 查找未签名 APK 文件路径
APK_UNSIGNED=$(find /workspace/platforms/android -type f -name "*-unsigned.apk" | head -n 1)
if [ -z "$APK_UNSIGNED" ]; then
  APK_UNSIGNED=$(find /workspace/platforms/android -type f -name "app-release-unsigned.apk" | head -n 1)
fi

if [ -z "$APK_UNSIGNED" ]; then
  echo "❌ 未找到 unsigned APK，请检查构建输出。"
  exit 1
fi

echo "✅ 未签名 APK 路径: $APK_UNSIGNED"

# 同时支持旧版本和新版本 Android 的签名验证
echo "$KEYSTORE_PASSWORD" | apksigner sign \
  --v1-signing-enabled true \
  --v2-signing-enabled true \
  --ks "$KEYSTORE_PATH" \
  --ks-key-alias "$KEY_ALIAS" \
  --ks-pass env:KEYSTORE_PASSWORD \
  --key-pass env:KEY_PASSWORD \
  "$APK_UNSIGNED"


apksigner verify --verbose "$APK_UNSIGNED"
echo "----------------------apksigner 验证签名有效性:--------------------------------"


zipalign -c -v 4 "$APK_UNSIGNED"
echo "----------------------zipalign 检查APK完整性--------------------------------"

aapt dump badging "$APK_UNSIGNED"
echo "----------------------aapt 查看APK详细信息:--------------------------------"

echo "------------------------------------------------------"
echo "🎉 APK 签名流程完成"
echo "------------------------------------------------------"