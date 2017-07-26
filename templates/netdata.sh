#!/usr/bin/env bash
# add user netdata
groupadd -r netdata
useradd -r -g netdata -c netdata -s $(which nologin 2>/dev/null || command -v nologin 2>/dev/null || echo '/bin/false') -d / netdata
usermod -a -G adm netdata
# additionally
chmod +x /etc/init.d/netdata
chkconfig --add netdata
# access
chmod 644 /etc/logrotate.d/netdata
chown -R netdata.netdata /var/cache/netdata/
chown -R netdata.netdata /var/lib/netdata/
NETDATA_CONF_DIR=/etc/netdata/
chown -R netdata.netdata $NETDATA_CONF_DIR
find $NETDATA_CONF_DIR -type f -exec chmod 0660 {} \;
find $NETDATA_CONF_DIR -type d -exec chmod 0775 {} \;
NETDATA_WEB_DIR=/usr/share/netdata/web
chown -R netdata.netdata $NETDATA_WEB_DIR
find $NETDATA_WEB_DIR -type f -exec chmod 0664 {} \;
find $NETDATA_WEB_DIR -type d -exec chmod 0775 {} \;
chown -R netdata.netdata "/usr/libexec/netdata"
find "/usr/libexec/netdata" -type f -exec chmod 0755 {} \;
find "/usr/libexec/netdata" -type d -exec chmod 0755 {} \;

