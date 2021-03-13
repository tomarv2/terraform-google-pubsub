locals {
  name = var.topic_name != null ? var.topic_name : "${var.teamid}-${var.prjid}"
}
resource "google_pubsub_topic" "topic" {
  count = var.create_topic ? 1 : 0

  name         = local.name
  project      = var.gcp_project
  labels       = merge(local.shared_tags)
  kms_key_name = var.topic_kms_key_name

  dynamic "message_storage_policy" {
    for_each = var.message_storage_policy
    content {
      allowed_persistence_regions = message_storage_policy.key == "allowed_persistence_regions" ? message_storage_policy.value : null
    }
  }
}