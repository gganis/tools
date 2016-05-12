#include <string.h>
#include <sys/utsname.h>

int uname(struct utsname *buf) {

  strcpy(buf->sysname, "Linux");
  strcpy(buf->nodename, "localhost");
  strcpy(buf->release, "2.6.32-431.29.2.el6.x86_64");
  strcpy(buf->version, "#1 SMP Wed Sep 10 11:13:12 CEST 2014");
  strcpy(buf->machine, "x86_64");
  return 0;
}



/*
sysname: Linux
nodename: ggslc6-prf-2.cern.ch
release: 2.6.32-431.29.2.el6.x86_64
version: #1 SMP Wed Sep 10 11:13:12 CEST 2014
machine: x86_64
*/
