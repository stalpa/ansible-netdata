#!/usr/bin/env bash
# this script will uninstall netdata
#echo >&2 "Stopping a possibly running netdata..."
for p in $(pidof netdata); do kill $p; done
sleep 2
deletedir() {
    if [ ! -z "$1" -a -d "$1" ]
        then
#        echo
#        echo "Deleting directory '$1' ..."
        rm -R "$1"
    fi
}
if [ ! -z "" -a -d "" ]
    then
#    # installation prefix was given
    deletedir ""
else
    # installation prefix was NOT given
    if [ -f "/usr/sbin/netdata" ]
        then
#        echo "Deleting /usr/sbin/netdata ..."
        rm -r "/usr/sbin/netdata"
    fi
    deletedir "/etc/netdata"
    deletedir "/usr/share/netdata"
    deletedir "/usr/libexec/netdata"
    deletedir "/var/lib/netdata"
    deletedir "/var/cache/netdata"
    deletedir "/var/log/netdata"
fi
if [ -f /etc/logrotate.d/netdata ]
    then
#    echo "Deleting /etc/logrotate.d/netdata ..."
    rm -r /etc/logrotate.d/netdata
fi
if [ -f /etc/systemd/system/netdata.service ]
    then
#    echo "Deleting /etc/systemd/system/netdata.service ..."
    rm -r /etc/systemd/system/netdata.service
fi
if [ -f /etc/init.d/netdata ]
    then
#    echo "Deleting /etc/init.d/netdata ..."
    rm -r /etc/init.d/netdata
fi
#remove the netdata user from the adm group
gpasswd -d netdata adm
#remove the user netdata
userdel netdata

