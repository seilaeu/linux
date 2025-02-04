#!/bin/bash

sudo /usr/bin/awk '!a[$0]++'  /root/.bash_history > /root/.bash_history.tmp && sudo mv /root/.bash_history.tmp /root/.bash_history
