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

output "pubsub_subscription_name" {
  description = "PubSub subscription name"
  value       = module.pubsub.pubsub_subscription_name
}

output "pubsub_message_retention" {
  description = "PubSub subscription retention"
  value       = module.pubsub.pubsub_message_retention
}
output "pubsub_subscription_id" {
  description = "PubSub subscription id"
  value       = module.pubsub.pubsub_subscription_id
}