terraform {
  required_version = ">= 1.0.1"
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.12.0"
    }
  }
}

provider "google" {
  region  = var.region
  project = var.project
}

module "pubsub" {
  source = "../"

  pull_subscriptions = [
    {
      name = "pull"
    },
  ]

  push_subscriptions = [
    {
      name          = "push"
      push_endpoint = "https://${var.project}.appspot.com/"
    },
  ]
  #-----------------------------------------------
  # Note: Do not change teamid and prjid once set.
  teamid = var.teamid
  prjid  = var.prjid
}
