#!/bin/bash
export LANG=en_US.UTF-8
export uuid=${UUID:-''}
export domain=${DOMAIN:-''}
export vl_port=${PORT:-''}
username=$(whoami)
if [ -z $vl_port ]; then
vl_port=$(shuf -i 10000-65535 -n 1)
fi
if [ -z $uuid ]; then
uuid=$(cat /proc/sys/kernel/random/uuid)
fi
ps aux | grep '[d]omains' | awk '{print $2}' | xargs -r kill -9
curl -s -o "/home/$username/domains/$domain/public_html/app.js" "https://raw.githubusercontent.com/yonggekkk/vless-nodejs/main/app.js"
curl -s -o "/home/$username/domains/$domain/public_html/package.json" "https://raw.githubusercontent.com/yonggekkk/vless-nodejs/main/package.json"
sed -i "s/('UUID', '')/('UUID', '$uuid')/g" "/home/$username/domains/$domain/public_html/app.js"
sed -i "s/('DOMAIN', '')/('DOMAIN', '$domain')/g" "/home/$username/domains/$domain/public_html/app.js"
sed -i "s/('PORT', '')/('PORT', '$vl_port')/g" "/home/$username/domains/$domain/public_html/app.js"
echo "https://$domain/$uuid" > "/home/$username/domains/keepsub.txt"
serv=$(hostname -s)
echo "---------------------------------------------"
echo "安装结束"
echo
echo "ctrl+选中下面网址，右击复制"
echo "https://$serv.webhostmost.com:2222/evo/user/plugins/nodejs_selector#/"
echo "请另外打开浏览器窗口，粘贴以上网址，可绕过限制进入Nodejs界面，设置相关参数即可"
echo "最后，打开支持保活的节点分享链接：https://$domain/$uuid 已保存在文件管理器中的keepsub.txt文件中"  
