#!/bin/bash
#
xhost +
if [ -z "$(pgrep xscreensaver)" ]; then
  su armax - -c "/usr/bin/xscreensaver -no-splash" &
fi

if [ -z "$(pgrep xcompmgr)" ]; then
  su armax - -c "/usr/bin/xcompmgr" &
fi

if [ -z "$(pgrep redshift)" ]; then
  su armax - -c "/usr/bin/redshift -l 59:18" &
fi
