# company
variable "company" {
  type = string
  description = "This variable defines the name of the company"
  default = "XSECpipelinetest"
}
# environment
variable "environment" {
  type = string
  description = "This variable defines the environment to be built"
  default = "prod"
}