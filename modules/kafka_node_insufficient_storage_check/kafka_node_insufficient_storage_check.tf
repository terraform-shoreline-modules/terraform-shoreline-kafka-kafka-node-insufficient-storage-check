resource "shoreline_notebook" "kafka_node_insufficient_storage_check" {
  name       = "kafka_node_insufficient_storage_check"
  data       = file("${path.module}/data/kafka_node_insufficient_storage_check.json")
  depends_on = [shoreline_action.invoke_delete_old_kafka_topics,shoreline_action.invoke_kafka_config_compression]
}

resource "shoreline_file" "delete_old_kafka_topics" {
  name             = "delete_old_kafka_topics"
  input_file       = "${path.module}/data/delete_old_kafka_topics.sh"
  md5              = filemd5("${path.module}/data/delete_old_kafka_topics.sh")
  description      = "Reduce the amount of data being stored on the Kafka node by deleting old data or implementing data retention policies."
  destination_path = "/tmp/delete_old_kafka_topics.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "kafka_config_compression" {
  name             = "kafka_config_compression"
  input_file       = "${path.module}/data/kafka_config_compression.sh"
  md5              = filemd5("${path.module}/data/kafka_config_compression.sh")
  description      = "Optimize the Kafka node's configuration to use storage more efficiently, such as compressing data or using a more effective storage engine."
  destination_path = "/tmp/kafka_config_compression.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_delete_old_kafka_topics" {
  name        = "invoke_delete_old_kafka_topics"
  description = "Reduce the amount of data being stored on the Kafka node by deleting old data or implementing data retention policies."
  command     = "`chmod +x /tmp/delete_old_kafka_topics.sh && /tmp/delete_old_kafka_topics.sh`"
  params      = ["PATH_TO_KAFKA_DATA_DIRECTORY","NUMBER_OF_DAYS"]
  file_deps   = ["delete_old_kafka_topics"]
  enabled     = true
  depends_on  = [shoreline_file.delete_old_kafka_topics]
}

resource "shoreline_action" "invoke_kafka_config_compression" {
  name        = "invoke_kafka_config_compression"
  description = "Optimize the Kafka node's configuration to use storage more efficiently, such as compressing data or using a more effective storage engine."
  command     = "`chmod +x /tmp/kafka_config_compression.sh && /tmp/kafka_config_compression.sh`"
  params      = ["PATH_TO_KAFKA_CONFIG_FILE"]
  file_deps   = ["kafka_config_compression"]
  enabled     = true
  depends_on  = [shoreline_file.kafka_config_compression]
}

