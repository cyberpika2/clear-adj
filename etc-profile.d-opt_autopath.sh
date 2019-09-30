#!/bin/bash
#####    ####
# automated idempotent $PATH adjustment for opt installed user programs /opt/<$program>/bin
# place as /etc/profile.d/opt_autopath.sh in clear
for \
    d in /opt/*/bin
    do
        test -d "$d" || continue
        case \
            :$PATH: in
            *:"$d":*);;
            *) PATH=${PATH:+$PATH:}$d;;
            esac
            done
