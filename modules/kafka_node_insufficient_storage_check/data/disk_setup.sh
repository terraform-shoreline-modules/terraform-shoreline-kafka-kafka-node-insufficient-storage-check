

#!/bin/bash



# Set variables for disk size and mount point

DISK_SIZE=${DISK_SIZE}

MOUNT_POINT=${MOUNT_POINT}



# Create a new disk partition

echo -e "n\np\n1\n\n\nw" | fdisk /dev/sdb



# Format the new partition as ext4

mkfs -t ext4 /dev/sdb1



# Mount the new partition to the specified mount point

mkdir $MOUNT_POINT

mount /dev/sdb1 $MOUNT_POINT



# Update /etc/fstab to ensure the new partition is mounted on boot

echo "/dev/sdb1 $MOUNT_POINT ext4 defaults 0 0" >> /etc/fstab



# Check the new disk is mounted and has the correct size

df -h $MOUNT_POINT