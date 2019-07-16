echo ASSERTBUILD $1

# Check that the group 'sf' is in the list
GROUP=""
for g in `groups sftnight | sed 's,^.*: *,,'` ; do
#   echo "$g"
   if test "x$GROUP" = "x" ; then
      GROUP="$g"
   fi
   if test "x$g" = "xsf" ; then
      GROUP="$g"
   fi
done
# Warn if not
if test ! "x$GROUP" = "xsf" ; then
   echo "Warning: 'sftnight' does not belong to group 'sf': using first group ($GROUP)" 
fi

function mkDirOwn {
# mkdir $1 and chown sftnight
        mkdir -p $1
        chown sftnight:$GROUP $1
}

function mountHere {
# mounts $1 at $2
    if ! ( mount | grep $2 ); then
        mkDirOwn $2
        mount $3 $1 $2
    fi
}

function mkPart {
# creates partition 1 on device $1
    if ! (fdisk -l $1 | grep ${1}1 ); then
            echo 'n
p
1


w
' | fdisk -u $1 && sleep 1 && mkfs.ext3 ${1}1
        fi
}

if [ "x$1" = "xstart" ]; then
# Create the partition on the second disk volume
    mkPart /dev/vdb 1
# Make sure /build is there (this is for Jenkins)
    mkDirOwn /mnt/build
    mountHere /dev/vdb1 /mnt/build
    chown sftnight:$GROUP /mnt/build
    (cd / && rm -f build && ln -s /mnt/build build)
fi
