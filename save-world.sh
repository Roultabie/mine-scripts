#!/bin/bash
WORLD=$1
SERVERPATH="/srv/minecraft"
SAVEDIR="saves"
LATEST="$WORLD_latest"
SAVEPATH="$SERVERPATH/$SAVEDIR"
$WORLDSAVEPATH="$SAVEPATH/$WORLD"

if [[ -d == $SERVERPATH/$WORLD ]]
    then
        mkdir -p "$WORLDSAVEPATH/$LATEST" 2>/dev/null
        if [[ -d == "$WORLDSAVEPATH/$LATEST" ]]
            then
                if [[ -f  "$WORLDSAVEPATH/$LATEST/level.dat"]]
                    then
                    LASTMODIF=`stat -c %Y $WORLDSAVEPATH/$LATEST`
                    tar czf $WORLDSAVEPATH/$LASTMODIF.tar.gz $WORLDSAVEPATH/$LATEST && wait
                fi
                rsync -ar $SERVERPATH/$WORLD/* $WORLDSAVEPATH/$LATEST/
        fi
fi
        