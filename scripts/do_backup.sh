#! /bin/sh

rm -f /var/backup/*.bak.tgz
nice -n 19 tar -czf /var/backup/home-`uname -n`-`date +%F`.bak.tgz /home/$USER
