

#!/bin/bash



# Set the path to the Kafka data directory

KAFKA_DATA_DIR=${PATH_TO_KAFKA_DATA_DIRECTORY}



# Set the number of days of data to retain

DAYS_TO_RETAIN=${NUMBER_OF_DAYS}



# Find all Kafka topic directories older than DAYS_TO_RETAIN

OLD_TOPIC_DIRS=$(find $KAFKA_DATA_DIR -maxdepth 1 -type d -mtime +$DAYS_TO_RETAIN -name "kafka-*")



# Delete the old topic directories

for DIR in $OLD_TOPIC_DIRS

do

    echo "Deleting Kafka topic directory: $DIR"

    rm -rf $DIR

done