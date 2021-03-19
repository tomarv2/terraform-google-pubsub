# https://github.com/terraform-google-modules/terraform-google-pubsub/blob/master/main.tf
resource "google_pubsub_subscription" "push_subscriptions" {
  count   = var.create_topic ? length(var.push_subscriptions) : 0

  name    = "${local.name}-${var.push_subscriptions[count.index].name}"
  topic   = google_pubsub_topic.topic.0.name
  project = var.gcp_project
  labels  = merge(local.shared_tags)
  ack_deadline_seconds = lookup(
    var.push_subscriptions[count.index],
    "ack_deadline_seconds",
    var.default_ack_deadline_seconds,
  )
  message_retention_duration = lookup(
    var.push_subscriptions[count.index],
    "message_retention_duration",
    null,
  )
  retain_acked_messages = lookup(
    var.push_subscriptions[count.index],
    "retain_acked_messages",
    null,
  )
  filter = lookup(
    var.push_subscriptions[count.index],
    "filter",
    null,
  )
  enable_message_ordering = lookup(
    var.push_subscriptions[count.index],
    "enable_message_ordering",
    null,
  )
  dynamic "expiration_policy" {
    // check if the 'expiration_policy' key exists, if yes, return a list containing it.
    for_each = contains(keys(var.push_subscriptions[count.index]), "expiration_policy") ? [var.push_subscriptions[count.index].expiration_policy] : []
    content {
      ttl = expiration_policy.value
    }
  }

  dynamic "dead_letter_policy" {
    for_each = (lookup(var.push_subscriptions[count.index], "dead_letter_topic", "") != "") ? [var.push_subscriptions[count.index].dead_letter_topic] : []
    content {
      dead_letter_topic     = lookup(var.push_subscriptions[count.index], "dead_letter_topic", "")
      max_delivery_attempts = lookup(var.push_subscriptions[count.index], "max_delivery_attempts", "5")
    }
  }

  dynamic "retry_policy" {
    for_each = (lookup(var.push_subscriptions[count.index], "maximum_backoff", "") != "") ? [var.push_subscriptions[count.index].maximum_backoff] : []
    content {
      maximum_backoff = lookup(var.push_subscriptions[count.index], "maximum_backoff", "")
      minimum_backoff = lookup(var.push_subscriptions[count.index], "minimum_backoff", "")
    }
  }

  push_config {
    push_endpoint = var.push_subscriptions[count.index]["push_endpoint"]

    // FIXME: This should be programmable, but nested map isn't supported at this time.
    //   https://github.com/hashicorp/terraform/issues/2114
    attributes = {
      x-goog-version = lookup(var.push_subscriptions[count.index], "x-goog-version", "v1")
    }

    dynamic "oidc_token" {
      for_each = (lookup(var.push_subscriptions[count.index], "oidc_service_account_email", "") != "") ? [true] : []
      content {
        service_account_email = lookup(var.push_subscriptions[count.index], "oidc_service_account_email", "")
        audience              = lookup(var.push_subscriptions[count.index], "audience", "")
      }
    }
  }
  depends_on = [
    google_pubsub_topic.topic,
  ]
}