<p align="center">
    <a href="https://github.com/tomarv2/terraform-google-pubsub/actions/workflows/pre-commit.yml" alt="Pre Commit">
        <img src="https://github.com/tomarv2/terraform-google-pubsub/actions/workflows/pre-commit.yml/badge.svg?branch=main" /></a>
    <a href="https://www.apache.org/licenses/LICENSE-2.0" alt="license">
        <img src="https://img.shields.io/github/license/tomarv2/terraform-google-pubsub" /></a>
    <a href="https://github.com/tomarv2/terraform-google-pubsub/tags" alt="GitHub tag">
        <img src="https://img.shields.io/github/v/tag/tomarv2/terraform-google-pubsub" /></a>
    <a href="https://github.com/tomarv2/terraform-google-pubsub/pulse" alt="Activity">
        <img src="https://img.shields.io/github/commit-activity/m/tomarv2/terraform-google-pubsub" /></a>
    <a href="https://stackoverflow.com/users/6679867/tomarv2" alt="Stack Exchange reputation">
        <img src="https://img.shields.io/stackexchange/stackoverflow/r/6679867"></a>
    <a href="https://twitter.com/intent/follow?screen_name=varuntomar2019" alt="follow on Twitter">
        <img src="https://img.shields.io/twitter/follow/varuntomar2019?style=social&logo=twitter"></a>
</p>

## Terraform module for Google PubSub

### Versions

- Module tested for Terraform 1.0.1.
- Google provider version [4.12.0](https://registry.terraform.io/providers/hashicorp/google/latest)
- `main` branch: Provider versions not pinned to keep up with Terraform releases
- `tags` releases: Tags are pinned with versions (use <a href="https://github.com/tomarv2/terraform-google-pubsub/tags" alt="GitHub tag">
        <img src="https://img.shields.io/github/v/tag/tomarv2/terraform-google-pubsub" /></a> in your releases)

### Usage

#### Option 1:

```
terrafrom init
terraform plan -var='teamid=tryme' -var='prjid=project1'
terraform apply -var='teamid=tryme' -var='prjid=project1'
terraform destroy -var='teamid=tryme' -var='prjid=project1'
```
**Note:** With this option please take care of remote state storage

#### Option 2:

##### Recommended method (stores remote state in remote backend(S3,  Azure storage, or Google bucket) using `prjid` and `teamid` to create directory structure):

- Create python 3.8+ virtual environment
```
python3 -m venv <venv name>
```

- Install package:
```
pip install tfremote --upgrade
```

- Set below environment variables:
```
export TF_GCLOUD_BUCKET=<remote state bucket name>
export TF_GCLOUD_PREFIX=<remote state bucket prefix>
export TF_GCLOUD_CREDENTIALS=<gcp credentials.json>
```

- Updated `examples` directory with required values.

- Run and verify the output before deploying:
```
tf -c=gcloud plan -var='teamid=foo' -var='prjid=bar'
```

- Run below to deploy:
```
tf -c=gcloud apply -var='teamid=foo' -var='prjid=bar'
```

- Run below to destroy:
```
tf -c=gcloud destroy -var='teamid=foo' -var='prjid=bar'
```

**Note:** Read more on [tfremote](https://github.com/tomarv2/tfremote)
##### PubSub Topic - pull & push subscription
```
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
```

Please refer to examples directory [link](examples) for references.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.1 |
| <a name="requirement_google"></a> [google](#requirement\_google) | ~> 4.12.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | ~> 4.12.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_pubsub_subscription.pull_subscriptions](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription) | resource |
| [google_pubsub_subscription.push_subscriptions](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_subscription) | resource |
| [google_pubsub_topic.topic](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/pubsub_topic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_topic"></a> [create\_topic](#input\_create\_topic) | Specify true if you want to create a topic | `bool` | `true` | no |
| <a name="input_default_ack_deadline_seconds"></a> [default\_ack\_deadline\_seconds](#input\_default\_ack\_deadline\_seconds) | Default ack deadline in seconds | `string` | `"10"` | no |
| <a name="input_message_storage_policy"></a> [message\_storage\_policy](#input\_message\_storage\_policy) | A map of storage policies. Default - inherit from organization's Resource Location Restriction policy. | `map(any)` | `{}` | no |
| <a name="input_prjid"></a> [prjid](#input\_prjid) | Name of the project/stack e.g: mystack, nifieks, demoaci. Should not be changed after running 'tf apply' | `string` | n/a | yes |
| <a name="input_pull_subscriptions"></a> [pull\_subscriptions](#input\_pull\_subscriptions) | The list of the pull subscriptions | `list(map(string))` | `[]` | no |
| <a name="input_push_subscriptions"></a> [push\_subscriptions](#input\_push\_subscriptions) | The list of the push subscriptions | `list(map(string))` | `[]` | no |
| <a name="input_teamid"></a> [teamid](#input\_teamid) | Name of the team/group e.g. devops, dataengineering. Should not be changed after running 'tf apply' | `string` | n/a | yes |
| <a name="input_topic_kms_key_name"></a> [topic\_kms\_key\_name](#input\_topic\_kms\_key\_name) | The resource name of the Cloud KMS CryptoKey to be used to protect access to messages published on this topic. | `string` | `null` | no |
| <a name="input_topic_name"></a> [topic\_name](#input\_topic\_name) | The Pub/Sub topic name | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_pubsub_pull_message_retention"></a> [pubsub\_pull\_message\_retention](#output\_pubsub\_pull\_message\_retention) | PubSub pull subscription retention |
| <a name="output_pubsub_pull_subscription_id"></a> [pubsub\_pull\_subscription\_id](#output\_pubsub\_pull\_subscription\_id) | PubSub pull subscription id |
| <a name="output_pubsub_pull_subscription_name"></a> [pubsub\_pull\_subscription\_name](#output\_pubsub\_pull\_subscription\_name) | PubSub pull subscription name |
| <a name="output_pubsub_push_message_retention"></a> [pubsub\_push\_message\_retention](#output\_pubsub\_push\_message\_retention) | PubSub push subscription retention |
| <a name="output_pubsub_push_subscription_id"></a> [pubsub\_push\_subscription\_id](#output\_pubsub\_push\_subscription\_id) | PubSub push subscription id |
| <a name="output_pubsub_push_subscription_name"></a> [pubsub\_push\_subscription\_name](#output\_pubsub\_push\_subscription\_name) | PubSub push subscription name |
| <a name="output_pubsub_topic_id"></a> [pubsub\_topic\_id](#output\_pubsub\_topic\_id) | PubSub topic id |
| <a name="output_pubsub_topic_name"></a> [pubsub\_topic\_name](#output\_pubsub\_topic\_name) | PubSub topic name |
| <a name="output_pubsub_topic_project"></a> [pubsub\_topic\_project](#output\_pubsub\_topic\_project) | PubSub topic project |
<!-- END_TF_DOCS -->
