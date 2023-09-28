resource "shoreline_notebook" "kafka_node_insufficient_storage_check" {
  name       = "kafka_node_insufficient_storage_check"
  data       = file("${path.module}/data/kafka_node_insufficient_storage_check.json")
  depends_on = [shoreline_action.invoke_disk_setup]
}

resource "shoreline_file" "disk_setup" {
  name             = "disk_setup"
  input_file       = "${path.module}/data/disk_setup.sh"
  md5              = filemd5("${path.module}/data/disk_setup.sh")
  description      = "Increase the storage capacity of the Kafka node by adding more disk space or upgrading to a larger storage device."
  destination_path = "/agent/scripts/disk_setup.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_disk_setup" {
  name        = "invoke_disk_setup"
  description = "Increase the storage capacity of the Kafka node by adding more disk space or upgrading to a larger storage device."
  command     = "`chmod +x /agent/scripts/disk_setup.sh && /agent/scripts/disk_setup.sh`"
  params      = ["DISK_SIZE","MOUNT_POINT"]
  file_deps   = ["disk_setup"]
  enabled     = true
  depends_on  = [shoreline_file.disk_setup]
}

