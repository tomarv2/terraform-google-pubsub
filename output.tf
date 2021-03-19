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

output "pubsub_subscription_name" {
  description = "PubSub subscription name"
  value       = join("", google_pubsub_subscription.pull_subscriptions.*.name)
}

output "pubsub_message_retention" {
  description = "PubSub subscription retention"
  value       = join("", google_pubsub_subscription.pull_subscriptions.*.message_retention_duration)
}
output "pubsub_subscription_id" {
  description = "PubSub subscription id"
  value       = join("", google_pubsub_subscription.pull_subscriptions.*.id)
}