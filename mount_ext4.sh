#!/system/bin/sh
export PATH=/system/bin:/system/xbin:$PATH
BLOCK_DEVICE=$1
MOUNT_POINT=$2
LOG_FILE="/dev/null"
LOG_LOCATION="/data/.fsck_log/"

if [ "${MOUNT_POINT}" == "/storage_int" ]; then
    mkdir ${LOG_LOCATION}
    busybox find /data/.fsck_log/ -type f -mtime +7  -exec rm {} \;
    TIMESTAMP=`date +%F_%H-%M-%S`
    LOG_FILE=${LOG_LOCATION}/storage_${TIMESTAMP}.log
fi

if [ -e ${BLOCK_DEVICE} ]; then

    mount -t ext4 -o nosuid,nodev,barrier=1,noauto_da_alloc ${BLOCK_DEVICE} ${MOUNT_POINT}

fi
