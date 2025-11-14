
#!/bin/bash
# 开始 release 构建（不签名）
echo "------------------------------------------------------"
echo "🏗️  正在构建 release APK（未签名）..."

# 进入项目目录
PROJECT_DIR=${PROJECT_DIR:-/workspace}
cd "$PROJECT_DIR" || { echo "❌ 项目目录不存在: $PROJECT_DIR"; exit 1; }
echo "当前目录: $(pwd)"

cordova build android --release --no-telemetry

echo "---- 结束构建 release APK（未签名）----------------------------------"