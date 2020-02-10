#!/bin/bash
# idempotent $PATH adjustment for /opt/<$program>/bin
# for automating the automated automation
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
