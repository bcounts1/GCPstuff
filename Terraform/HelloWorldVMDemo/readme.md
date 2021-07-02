# Simple Hello World VM Demo

Simple web server compute instance deployment. This particular demo serves 3 purposes:

1.) To document some of the fundamental HCL syntax needed to deploy a web server on GCE.

2.) Create a sample environment that is "free-tier" friendly

3.) Observe some of the basic GCP environment configurations

## Notes:
- You can run this in cloud shell, however if you are running this from an external environment, you will need to make sure you  configure the appropriate configuration. Please review the following document:
[Google Provider Configuration Reference - Authentication](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference#authentication)
- Free tier is very restrictive in what can be deployed. It does not support windows VMs nor SSD local disk. 
- This config assumes you are deploying to a project with the default network. I will be putting together a more complex demo involving custom VPCs and multiple instances in the future. 