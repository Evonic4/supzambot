# supzambot
  
install from root:  
cd /usr/share && git clone https://github.com/Evonic4/supzambot.git && mv ./supzambot ./trbot2 && cd ./trbot2 && chmod +rx /usr/share/trbot2/setup.sh && /usr/share/trbot2/setup.sh

nano crontab -e
@reboot sleep 60 && rm -f /usr/share/trbot2/rtb_pid.txt && su mastmetric -c '/usr/share/trbot2/trbot.sh' -s /bin/bash &
