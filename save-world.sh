#!/bin/bash
WORLD=$1
SERVERPATH="/srv/minecraft"
SAVEDIR="saves"
LASTEST=$WORLD"_latest"
SAVEPATH="$SERVERPATH/$SAVEDIR"
WORLDSAVEPATH="$SAVEPATH/$WORLD"
if [[ -d "$SERVERPATH/$WORLD" ]]
    then
        mkdir -p "$WORLDSAVEPATH/$LASTEST" #2>/dev/null
        if [[ -d "$WORLDSAVEPATH/$LASTEST" ]]
            then
                if [[ -f "$WORLDSAVEPATH/$LASTEST/level.dat" ]]
                    then
                    LASTMODIF=`stat -c %Y $WORLDSAVEPATH/$LASTEST`
                    tar czf $WORLDSAVEPATH/$LASTMODIF.tar.gz $WORLDSAVEPATH/$LASTEST && wait
                fi
                rsync -ar $SERVERPATH/$WORLD/* $WORLDSAVEPATH/$LASTEST/ && wait
        fi
fi
        
