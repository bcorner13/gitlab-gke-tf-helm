## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_gitlab"></a> [gitlab](#module\_gitlab) | ../modules/gke_gitlab | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_certmanager_email"></a> [certmanager\_email](#input\_certmanager\_email) | Email used to retrieve SSL certificates from Let's Encrypt | `any` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | The project ID to deploy to | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_gitlab_url"></a> [gitlab\_url](#output\_gitlab\_url) | n/a |
| <a name="output_root_password_instructions"></a> [root\_password\_instructions](#output\_root\_password\_instructions) | n/a |
