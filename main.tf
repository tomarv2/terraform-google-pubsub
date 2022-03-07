resource "google_pubsub_topic" "topic" {
  count = var.create_topic ? 1 : 0

  name = local.name

  labels       = merge(local.shared_labels)
  kms_key_name = var.topic_kms_key_name

  dynamic "message_storage_policy" {
    for_each = var.message_storage_policy
    content {
      allowed_persistence_regions = message_storage_policy.key == "allowed_persistence_regions" ? message_storage_policy.value : null
    }
  }
}
