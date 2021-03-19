locals {
  shared_tags = map(
    "name", "${var.teamid}-${var.prjid}",
    "team", var.teamid,
    "project", var.prjid
  )

  name                     = var.topic_name != null ? var.topic_name : "${var.teamid}-${var.prjid}"
  pubsub_svc_account_email = "service-${var.gcp_project}@gcp-sa-pubsub.iam.gserviceaccount.com"
}
