#!/bin/sh

#  ci_post_clone.sh
#  Baobab
#
#  Created by 이정훈 on 8/20/24.
#

# ServiceInfo.plist 변수 변경
echo "환경변수 참조 ServiceInfo.plist 생성"

cat <<EOF > "/Volumes/workspace/repository/Baobab/Application/ServiceInfo.plist"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Test_URL</key>
    <string>${Test_URL}</string>
    <key>User_Open_URL</key>
    <string>${User_Open_URL}</string>
    <key>User_URL</key>
    <string>${User_URL}</string>
    <key>Warehouse_URL</key>
    <string>${Warehouse_URL}</string>
</dict>
</plist>
EOF

echo "ServiceInfo.plist 생성 완료"
