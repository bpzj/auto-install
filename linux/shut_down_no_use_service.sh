# 关闭无用的服务
sudo apt remove --purge bluetooth
sudo systemctl stop bluetooth
sudo systemctl disable bluetooth
sudo systemctl stop apt-daily.service
sudo systemctl stop apt-daily.timer
sudo systemctl stop apt-daily-upgrade.service
sudo systemctl stop apt-daily-upgrade.timer
sudo systemctl disable apt-daily.service
sudo systemctl disable apt-daily.timer
sudo systemctl disable apt-daily-upgrade.service
sudo systemctl disable apt-daily-upgrade.timer


