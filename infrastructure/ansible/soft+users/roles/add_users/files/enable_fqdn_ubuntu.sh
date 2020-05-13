#!/bin/bash
name=$( find /home/* -maxdepth 0 -type d | cut -c 7- )
for list in $name
do
        grep 'u@\\h' /home/$list/.bashrc -P -R -I -l | xargs sed -i 's/u@\\h/u@\\H/g'
done
grep 'u@\\h' /root/.bashrc -P -R -I -l | xargs sed -i 's/u@\\h/u@\\H/g'
