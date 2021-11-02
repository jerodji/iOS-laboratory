#!/bin/bash
echo ""
echo "▶️ 准备提交 iOS-laboratory ......"
cd ~/Documents/repositories/iOS-laboratory
git pull
git add .
# echo "请输入提交信息"
# read MSG
# git commit -m "$MSG"
git commit -m "update"
git push
echo "✅ 提交完成 iOS-laboratory "