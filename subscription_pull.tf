locals {
  default_ack_deadline_seconds = 10
  pubsub_svc_account_email     = "service-${var.gcp_project}@gcp-sa-pubsub.iam.gserviceaccount.com"
}

resource "google_pubsub_subscription" "pull_subscriptions" {
  count = var.create_topic ? length(var.pull_subscriptions) : 0

  name    = "${var.teamid}-${var.prjid}-${var.pull_subscriptions[count.index].name}"
  topic   = google_pubsub_topic.topic.0.name
  project = var.gcp_project
  labels  = merge(local.shared_tags)
  ack_deadline_seconds = lookup(
    var.pull_subscriptions[count.index],
    "ack_deadline_seconds",
    local.default_ack_deadline_seconds,
  )
  message_retention_duration = lookup(
    var.pull_subscriptions[count.index],
    "message_retention_duration",
    null,
  )
  retain_acked_messages = lookup(
    var.pull_subscriptions[count.index],
    "retain_acked_messages",
    null,
  )
  filter = lookup(
    var.pull_subscriptions[count.index],
    "filter",
    null,
  )
  enable_message_ordering = lookup(
    var.pull_subscriptions[count.index],
    "enable_message_ordering",
    null,
  )
  dynamic "expiration_policy" {
    // check if the 'expiration_policy' key exists, if yes, return a list containing it.
    for_each = contains(keys(var.pull_subscriptions[count.index]), "expiration_policy") ? [var.pull_subscriptions[count.index].expiration_policy] : []
    content {
      ttl = expiration_policy.value
    }
  }

  dynamic "dead_letter_policy" {
    for_each = (lookup(var.pull_subscriptions[count.index], "dead_letter_topic", "") != "") ? [var.pull_subscriptions[count.index].dead_letter_topic] : []
    content {
      dead_letter_topic     = lookup(var.pull_subscriptions[count.index], "dead_letter_topic", "")
      max_delivery_attempts = lookup(var.pull_subscriptions[count.index], "max_delivery_attempts", "5")
    }
  }

  dynamic "retry_policy" {
    for_each = (lookup(var.pull_subscriptions[count.index], "maximum_backoff", "") != "") ? [var.pull_subscriptions[count.index].maximum_backoff] : []
    content {
      maximum_backoff = lookup(var.pull_subscriptions[count.index], "maximum_backoff", "")
      minimum_backoff = lookup(var.pull_subscriptions[count.index], "minimum_backoff", "")
    }
  }

  depends_on = [
    google_pubsub_topic.topic,
  ]
}