output "pubsub_topic_name" {
  description = "PubSub topic name"
  value       = module.pubsub.pubsub_topic_name
}

output "pubsub_topic_id" {
  description = "PubSub topic id"
  value       = module.pubsub.pubsub_topic_id
}

output "pubsub_topic_project" {
  description = "PubSub topic project"
  value       = module.pubsub.pubsub_topic_project
}

output "pubsub_pull_subscription_name" {
  description = "PubSub pull subscription name"
  value       = module.pubsub.pubsub_pull_subscription_name
}

output "pubsub_pull_message_retention" {
  description = "PubSub pull subscription retention"
  value       = module.pubsub.pubsub_pull_message_retention
}
output "pubsub_pull_subscription_id" {
  description = "PubSub pull subscription id"
  value       = module.pubsub.pubsub_pull_subscription_id
}

output "pubsub_push_subscription_name" {
  description = "PubSub push subscription name"
  value       = module.pubsub.pubsub_push_subscription_name
}

output "pubsub_push_message_retention" {
  description = "PubSub push subscription retention"
  value       = module.pubsub.pubsub_push_message_retention
}

output "pubsub_push_subscription_id" {
  description = "PubSub push subscription id"
  value       = module.pubsub.pubsub_push_subscription_id
}