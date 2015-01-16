
# Guess which system we are (deb or rh), if not specified
SYST=$1
if test "x$SYST" = "x" ; then
   if test -f /etc/redhat-release; then
      SYST="rh"
      SUGRP="wheel"
   elif test -f /etc/debian_version; then
      SYST="deb"
      SUGRP="sudo,admin"
   else
      echo "Unsupported system"
      exit 1
   fi
fi
echo "Setting up 'sftadmin' for $SYST system ..."

UUID="75760"
SFGID="2735"
# Groups and users
if test "x$SYST" = "xrh" ; then
   uac=`which useraddcern > /dev/null 2>&1`
   if test "x$uac" = "x" ; then
      groupadd --gid $SFGID sf
      useradd --shell /bin/bash --uid $UUID --gid $SFGID --groups $SUGRP sftadmin
      passwd sftadmin
   else
      addusercern sftadmin
      usermod -G $SUGRP sftadmin
   fi
else
   addgroup --gid $SFGID sf
   adduser --shell /bin/bash --uid $UUID --gid $SFGID sftadmin
   usermod -G $SUGRP sftadmin
fi
grep $SUGRP /etc/group


