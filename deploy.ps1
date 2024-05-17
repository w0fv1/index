# 忽略错误
$ErrorActionPreference = "Stop"

# 构建
yarn run docs:build

# 进入待发布的目录
Set-Location -Path .vitepress/dist

# 初始化git仓库
git init
git add -A
git commit -m 'deploy'

# 推送到远程仓库的pages分支
git push -f git@github.com:w0fv1/index.git main:pages

# 返回原目录
Set-Location -Path ..\..

# 删除dist文件夹
Remove-Item -Recurse -Force .vitepress/dist