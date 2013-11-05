#!/bin/bash
LOG_TITLE="Minecraft"
LOGFILE=/minecraft/server.log
IPADDR="192.168.1.10"
PORT="25565"
RESTART_CMD="systemctl restart minecraftd"

netstat -ant | grep "$IPADDR:$PORT.*ESTABLISHED"

if [[ $? == 0 ]]
    then 
        echo "$(date) : $LOG_TITLE : one or more players are connected, waiting ..." >> /var/log/messages
        while  inotifywait -q -e modify  $LOGFILE
            do
                if tail -n1 $LOGFILE | grep '\[INFO\] \<..*\> lost connection'
                    then
                        echo "$(date) $LOG_TITLE : players are disconnected" >> /var/log/messages
                        echo "$(date) $LOG_TITLE : restarting ..." >> /var/log/messages
                        while netstat -ant | grep "$IPADDR:$PORT.*ESTABLISHED"
                            do
                                echo "$(date) : $LOG_TITLE : waiting for a disconnection ..." >> /var/log/messages
                                sleep 60
                        done
                        ($RESTART_CMD && wait ) 
                        echo "$(date) $LOG_TITLE : restarted, now it's time to play !" >> /var/log/messages
                        break
                fi
        done
        else 
            echo "$(date) $LOG_TITLE : restarting ..." >> /var/log/messages
            ($RESTART_CMD && wait )
            echo "$(date) $LOG_TITLE : restarted, now it's time to play !" >> /var/log/messages
fi