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
  gamesg/cordovabuilder:v1.0.0-rc.5 bash -c "
    ln -sfn /opt/app-env/build-scripts /workspace/build-scripts-short && 
    nohup sh build-scripts-short/apk-automatic-v2.sh > nohup.log 2>&1 &
    exec /bin/bash"