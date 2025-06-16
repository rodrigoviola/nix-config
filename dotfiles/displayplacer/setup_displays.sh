#!/bin/bash

host=$(scutil --get LocalHostName)

if [ "$host" = "MacBook-Pro-M1" ]; then
  displayplacer \
    "id:s4251086178 res:2056x1329 hz:120 color_depth:8 enabled:true scaling:on origin:(0,0) degree:0" \
    "id:s573748 res:2560x1440 hz:60 color_depth:8 enabled:true scaling:on origin:(1210,-1440) degree:0" \
    "id:s573747 res:2560x1440 hz:60 color_depth:8 enabled:true scaling:on origin:(-1350,-1440) degree:0"
elif [ "$host" = "MacBook-Pro-2013" ]; then
  displayplacer \
    "id:s0 res:1920x1200 color_depth:4 enabled:true scaling:on origin:(0,0) degree:0"
else
  echo "No matching hostname found. Skipping display layout."
fi
