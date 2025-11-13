#!/bin/bash
# 进入项目目录
PROJECT_DIR=${PROJECT_DIR:-/workspace}
cd "$PROJECT_DIR" || { echo "❌ 项目目录不存在: $PROJECT_DIR"; exit 1; }
echo "当前目录: $(pwd)"

# 开始 release 构建（不签名）
echo "------------------------------------------------------"
echo "🏗️  正在构建 release APK（未签名）..."
cordova build android --release --no-telemetry

echo "------------------------------------------------------"
echo "📦 构建 APK 完成"
echo "------------------------------------------------------"


echo "🔑 签名 APK..."

# 检查变量
echo "🔑 检查环境变量..."
if [ -z "$KEYSTORE_PATH" ] || [ -z "$KEY_ALIAS" ] || [ -z "$KEYSTORE_PASSWORD" ] || [ -z "$KEY_PASSWORD" ]; then  echo "❌ 签名所需的环境变量未全部设置。请确保以下变量已设置："
  echo "   KEYSTORE_PATH, KEY_ALIAS, KEYSTORE_PASSWORD, KEY_PASSWORD"
  echo "------------------------------------------------------"
  exit 1
fi

# 查找未签名 APK 文件路径
APK_UNSIGNED=$(find ./platforms/android -type f -name "*-unsigned.apk" | head -n 1)
if [ -z "$APK_UNSIGNED" ]; then
  APK_UNSIGNED=$(find ./platforms/android -type f -name "app-release-unsigned.apk" | head -n 1)
fi

if [ -z "$APK_UNSIGNED" ]; then
  echo "❌ 未找到 unsigned APK，请检查构建输出。"
  exit 1
fi

echo "✅ 未签名 APK 路径: $APK_UNSIGNED"

# 使用环境变量中的密码进行签名
echo "$KEYSTORE_PASSWORD" | jarsigner -verbose \
  -sigalg SHA1withRSA \
  -digestalg SHA1 \
  -keystore "$KEYSTORE_PATH" \
  -storepass:env KEYSTORE_PASSWORD \
  -keypass:env KEY_PASSWORD \
  "$APK_UNSIGNED" \
  "$KEY_ALIAS"

echo "------------------------------------------------------"
echo "🎉 APK 签名流程完成"
echo "------------------------------------------------------"