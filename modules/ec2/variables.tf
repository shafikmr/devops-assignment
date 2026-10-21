
variable "instances" {
  description = "Configuration for all five EC2 instances"

  type = map(object({
    instance_type   = string
    volume_type     = string
    volume_size     = number
    key_name        = string
    iops            = optional(number)
    prevent_destroy = bool
  }))

  validation {
    condition     = length(var.instances) == 5
    error_message = "Exactly five EC2 instances must be configured."
  }

  validation {
    condition = alltrue([
      for instance in values(var.instances) :
      contains(["gp2", "gp3", "standard", "io1", "io2"], instance.volume_type)
    ])
    error_message = "Volume types must be gp2, gp3, standard, io1, or io2."
  }

  validation {
    condition = alltrue([
      for instance in values(var.instances) :
      contains(["io1", "io2"], instance.volume_type)
      ? try(instance.iops >= 100, false)
      : true
    ])
    error_message = "io1 and io2 volumes must specify at least 100 IOPS."
  }
}

variable "environment" {
  type    = string
  default = "dev"
}

variable "owner" {
  type    = string
  default = "devops-assignment"
}
