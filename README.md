
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Kafka node insufficient storage check
---

This incident type occurs when a Kafka node has insufficient storage space available. Kafka nodes are responsible for storing and processing streams of data in a Kafka cluster. When a node runs out of storage space, it may cause data loss or processing errors. This can impact the overall performance and reliability of the Kafka cluster. To prevent this, it is important to regularly monitor and manage the storage capacity of Kafka nodes.

### Parameters
```shell
export MOUNT_POINT="PLACEHOLDER"

export DIRECTORY="PLACEHOLDER"

export KAFKA_LOG_DIRECTORY="PLACEHOLDER"

export BOOTSTRAP_SERVER="PLACEHOLDER"

export TOPIC_NAME="PLACEHOLDER"

export DISK_SIZE="PLACEHOLDER"
```

## Debug

### Check disk usage on the Kafka node
```shell
df -h ${MOUNT_POINT}
```

### Check the available space on the Kafka node
```shell
du -sh ${DIRECTORY}
```

### Check the size of Kafka logs on the node
```shell
du -sh ${KAFKA_LOG_DIRECTORY}
```

### Check the current partition status of Kafka topics
```shell
kafka-topics --describe --bootstrap-server ${BOOTSTRAP_SERVER} --topic ${TOPIC_NAME}
```

### Check the status of the Kafka broker and its partitions
```shell
kafka-broker-api-versions.sh --bootstrap-server ${BOOTSTRAP_SERVER}
```

### Check the replication status of Kafka topics
```shell
kafka-topics --describe --bootstrap-server ${BOOTSTRAP_SERVER} --topic ${TOPIC_NAME} --under-replicated-partitions
```

## Repair

### Increase the storage capacity of the Kafka node by adding more disk space or upgrading to a larger storage device.
```shell


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


```