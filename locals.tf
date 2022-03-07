locals {
  name = var.topic_name != null ? var.topic_name : "${var.teamid}-${var.prjid}"
  # pubsub_svc_account_email = "service-${data.google_project.project.number}@gcp-sa-pubsub.iam.gserviceaccount.com"
}

# data "google_project" "project" {}
