bash

#!/bin/bash



# Set Kafka configuration file path

KAFKA_CONFIG_PATH=${PATH_TO_KAFKA_CONFIG_FILE}



# Enable data compression in the Kafka configuration file

sed -i 's/^#compression.type=.*/compression.type=snappy/' $KAFKA_CONFIG_PATH



# Restart the Kafka service to apply the configuration changes

systemctl restart kafka.service