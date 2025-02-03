#!/bin/bash

/usr/bin/awk '!a[$0]++'  /home/seilaeu/.bash_history > /home/seilaeu/.bash_history.tmp && mv /home/seilaeu/.bash_history.tmp /home/seilaeu/.bash_history
