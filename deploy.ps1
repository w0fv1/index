# 忽略错误
$ErrorActionPreference = "Stop"

# 打印开始部署日志
Write-Host "开始部署流程..." -ForegroundColor Green

# 检查是否安装了yarn
if (-not (Get-Command "yarn" -ErrorAction SilentlyContinue)) {
    Write-Error "未检测到 Yarn，请先安装 Yarn!"
    exit
}

# 构建文档
Write-Host "正在构建文档..." -ForegroundColor Cyan
yarn run docs:build
if ($?) {
    Write-Host "文档构建完成!" -ForegroundColor Green
} else {
    Write-Error "文档构建失败，请检查错误信息!"
    exit
}

# 进入待发布的目录
Write-Host "进入构建输出目录: .vitepress/dist" -ForegroundColor Cyan
Set-Location -Path .vitepress/dist

# 初始化git仓库
Write-Host "初始化 Git 仓库..." -ForegroundColor Cyan
git init
if ($?) {
    Write-Host "Git 仓库初始化完成!" -ForegroundColor Green
} else {
    Write-Error "Git 仓库初始化失败，请检查权限或文件夹状态!"
    exit
}

# 添加文件并提交
Write-Host "添加文件到 Git 暂存区..." -ForegroundColor Cyan
git add -A
Write-Host "提交更改..." -ForegroundColor Cyan
git commit -m 'deploy'

if ($?) {
    Write-Host "文件提交成功!" -ForegroundColor Green
} else {
    Write-Error "提交失败，请检查 Git 状态!"
    exit
}

# 添加远程仓库
Write-Host "添加远程仓库: git@github.com:w0fv1/index.git" -ForegroundColor Cyan
git remote add origin git@github.com:w0fv1/index.git
if ($?) {
    Write-Host "远程仓库添加成功!" -ForegroundColor Green
} else {
    Write-Host "远程仓库添加失败，请检查 Git 配置!"
}

# 创建并切换到 pages 分支
Write-Host "创建并切换到分支: pages" -ForegroundColor Cyan
git branch -m main pages
if ($?) {
    Write-Host "分支创建并切换成功!" -ForegroundColor Green
} else {
    Write-Error "分支操作失败，请检查 Git 配置!"
    exit
}

# 推送到远程仓库的 pages 分支
Write-Host "推送到远程仓库的 pages 分支..." -ForegroundColor Cyan
git push -f git@github.com:w0fv1/index.git pages
if ($?) {
    Write-Host "推送成功!" -ForegroundColor Green
} else {
    Write-Error "推送失败，请检查网络连接或远程仓库权限!"
    exit
}

# 返回原目录
Write-Host "返回项目根目录..." -ForegroundColor Cyan
Set-Location -Path ..\..

# 删除 dist 文件夹
Write-Host "删除构建目录: .vitepress/dist" -ForegroundColor Cyan
Remove-Item -Recurse -Force .vitepress/dist
if ($?) {
    Write-Host "构建目录删除成功!" -ForegroundColor Green
} else {
    Write-Error "删除构建目录失败，请检查文件夹权限!"
    exit
}

# 部署完成
Write-Host "部署完成!" -ForegroundColor Green
