output "pubsub_topic_name" {
  description = "PubSub topic name"
  value       = join("", google_pubsub_topic.topic.*.name)
}

output "pubsub_topic_id" {
  description = "PubSub topic id"
  value       = join("", google_pubsub_topic.topic.*.id)
}

output "pubsub_topic_project" {
  description = "PubSub topic project"
  value       = join("", google_pubsub_topic.topic.*.project)
}

output "pubsub_pull_subscription_name" {
  description = "PubSub pull subscription name"
  value       = join("", google_pubsub_subscription.pull_subscriptions.*.name)
}

output "pubsub_pull_message_retention" {
  description = "PubSub pull subscription retention"
  value       = join("", google_pubsub_subscription.pull_subscriptions.*.message_retention_duration)
}

output "pubsub_pull_subscription_id" {
  description = "PubSub pull subscription id"
  value       = join("", google_pubsub_subscription.pull_subscriptions.*.id)
}

output "pubsub_push_subscription_name" {
  description = "PubSub push subscription name"
  value       = join("", google_pubsub_subscription.push_subscriptions.*.name)
}

output "pubsub_push_message_retention" {
  description = "PubSub push subscription retention"
  value       = join("", google_pubsub_subscription.push_subscriptions.*.message_retention_duration)
}

output "pubsub_push_subscription_id" {
  description = "PubSub push subscription id"
  value       = join("", google_pubsub_subscription.push_subscriptions.*.id)
}
