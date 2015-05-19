rm -rf /var/spool/abrt/*
unset HISTFILE

rm -f /root/.bash_history /home/*/.bash_history
rm -f /var/lib/dhclient/*
rm -f /etc/sysconfig/iptables
service iptables restart
yum clean all
rm -rf /var/cache/yum/*
rm -rf /root/.ssh/ /home/*/.ssh/

echo -n '' > /etc/udev/rules.d/75-persistent-net-generator.rules
echo -n '' > /etc/udev/rules.d/70-persistent-net.rules

rm -f /etc/ssh/ssh_*_key
rm -rf /var/lib/cloud
rm -rf /tmp/*
userdel -frZ cloud-user

rm -rf \
  /etc/Pegasus/*.cnf \
  /etc/Pegasus/*.crt \
  /etc/Pegasus/*.csr \
  /etc/Pegasus/*.pem \
  /etc/Pegasus/*.srl \
  /root/anaconda-ks.cfg \
  /root/anaconda-post.log \
  /root/initial-setup-ks.cfg \
  /root/install.log \
  /root/install.log.syslog \
  /var/cache/fontconfig/* \
  /var/cache/gdm/* \
  /var/cache/man/* \
  /var/lib/AccountService/users/* \
  /var/lib/fprint/* \
  /var/lib/logrotate.status \
  /var/log/*.log* \
  /var/log/BackupPC/LOG \
  /var/log/ConsoleKit/* \
  /var/log/anaconda.syslog \
  /var/log/anaconda/* \
  /var/log/apache2/*_log \
  /var/log/apache2/*_log-* \
  /var/log/apt/* \
  /var/log/aptitude* \
  /var/log/audit/* \
  /var/log/btmp* \
  /var/log/ceph/*.log \
  /var/log/chrony/*.log \
  /var/log/cron* \
  /var/log/cups/*_log \
  /var/log/debug* \
  /var/log/dmesg* \
  /var/log/exim4/* \
  /var/log/faillog* \
  /var/log/gdm/* \
  /var/log/glusterfs/*glusterd.vol.log \
  /var/log/glusterfs/glusterfs.log \
  /var/log/httpd/*log \
  /var/log/installer/* \
  /var/log/jetty/jetty-console.log \
  /var/log/journal/* \
  /var/log/lastlog* \
  /var/log/libvirt/libvirtd.log \
  /var/log/libvirt/lxc/*.log \
  /var/log/libvirt/qemu/*.log \
  /var/log/libvirt/uml/*.log \
  /var/log/lightdm/* \
  /var/log/mail/* \
  /var/log/maillog* \
  /var/log/messages* \
  /var/log/ntp \
  /var/log/ntpstats/* \
  /var/log/ppp/connect-errors \
  /var/log/rhsm/* \
  /var/log/sa/* \
  /var/log/secure* \
  /var/log/setroubleshoot/*.log \
  /var/log/spooler* \
  /var/log/squid/*.log \
  /var/log/syslog* \
  /var/log/tallylog* \
  /var/log/tuned/tuned.log \
  /var/log/wtmp* \
  /var/named/data/named.run \
  /var/log/cloud-init.log
