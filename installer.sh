#!/usr/bin/expect -f

spawn ./ncalayer.sh --nogui
expect "Укажите путь, куда будет установлен NCALayer >"
send "/opt/ncalayer/\r"
expect "Хотите поместить NCALayer в автозагрузку?"
send "N\r"
interact
