variable "backend" {
  type = object({
    resourcegroupname  = string
    storageaccountname = string
    containername      = string
    keytfstate         = string
  })
  default = [
    {
      resourcegroupname  = "rg-ts-state-xsec"
      storageaccountname = "saxsectf"
      containername      = "terraform-state"
      keytfstate         = "terraform.tfstate"
    }
  ]
}

