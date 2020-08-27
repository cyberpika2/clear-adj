#!/bin/bash
# idempotent $PATH adjustment for clear linux
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
