variable "zones" {
  description = "DNS zones configuration for both public and private zones"
  type = object({
    public = optional(map(object({
      name                = string
      resource_group_name = optional(string)
      use_existing_zone   = optional(bool, false)
      tags                = optional(map(string))
      soa_record = optional(object({
        email         = string
        ttl           = optional(number, 3600)
        expire_time   = optional(number, 2419200)
        retry_time    = optional(number, 300)
        minimum_ttl   = optional(number, 300)
        refresh_time  = optional(number, 3600)
        serial_number = optional(number, 1)
        tags          = optional(map(string))
      }))
      records = optional(object({
        a = optional(map(object({
          name               = optional(string)
          ttl                = number
          records            = list(string)
          tags               = optional(map(string))
          target_resource_id = optional(string)
        })), {})
        aaaa = optional(map(object({
          name               = optional(string)
          ttl                = number
          records            = list(string)
          tags               = optional(map(string))
          target_resource_id = optional(string)
        })), {})
        caa = optional(map(object({
          name = optional(string)
          ttl  = number
          records = list(object({
            flags = number
            tag   = string
            value = string
          }))
          tags = optional(map(string))
        })), {})
        cname = optional(map(object({
          name               = optional(string)
          ttl                = number
          record             = string
          tags               = optional(map(string))
          target_resource_id = optional(string)
        })), {})
        mx = optional(map(object({
          name = optional(string)
          ttl  = number
          records = list(object({
            preference = number
            exchange   = string
          }))
          tags = optional(map(string))
        })), {})
        ns = optional(map(object({
          name    = optional(string)
          ttl     = number
          records = list(string)
          tags    = optional(map(string))
        })), {})
        ptr = optional(map(object({
          name    = optional(string)
          ttl     = number
          records = list(string)
          tags    = optional(map(string))
        })), {})
        srv = optional(map(object({
          name = optional(string)
          ttl  = number
          records = map(object({
            priority = number
            weight   = number
            port     = number
            target   = string
          }))
          tags = optional(map(string))
        })), {})
        txt = optional(map(object({
          name    = optional(string)
          ttl     = number
          records = list(string)
          tags    = optional(map(string))
        })), {})
      }), {})
    })), {})
    private = optional(map(object({
      name                = string
      resource_group_name = optional(string)
      use_existing_zone   = optional(bool, false)
      tags                = optional(map(string))
      virtual_network_links = optional(map(object({
        virtual_network_id   = string
        registration_enabled = optional(bool, false)
        resolution_policy    = optional(string)
        tags                 = optional(map(string))
      })))
      soa_record = optional(object({
        email        = string
        expire_time  = optional(number, 2419200)
        minimum_ttl  = optional(number, 10)
        refresh_time = optional(number, 3600)
        retry_time   = optional(number, 300)
        ttl          = optional(number, 3600)
        tags         = optional(map(string))
      }))
      records = optional(object({
        a = optional(map(object({
          name    = optional(string)
          ttl     = number
          records = list(string)
          tags    = optional(map(string))
        })), {})
        cname = optional(map(object({
          name   = optional(string)
          ttl    = number
          record = string
          tags   = optional(map(string))
        })), {})
        mx = optional(map(object({
          name = optional(string)
          ttl  = number
          records = list(object({
            preference = number
            exchange   = string
          }))
          tags = optional(map(string))
        })), {})
        ptr = optional(map(object({
          name    = optional(string)
          ttl     = number
          records = list(string)
          tags    = optional(map(string))
        })), {})
        srv = optional(map(object({
          name = optional(string)
          ttl  = number
          records = map(object({
            priority = number
            weight   = number
            port     = number
            target   = string
          }))
          tags = optional(map(string))
        })), {})
        txt = optional(map(object({
          name    = optional(string)
          ttl     = number
          records = list(string)
          tags    = optional(map(string))
        })), {})
      }), {})
    })), {})
    use_existing_zone = optional(bool, false)
  })
  default = {}
}

variable "use_existing_private_dns_zone" {
  description = "whether to use existing private dns zones"
  type        = bool
  default     = false
}

variable "virtual_network_links" {
  description = "Virtual network links to apply to all private DNS zones (fallback when zone-specific links are not defined)"
  type = map(object({
    virtual_network_id   = string
    registration_enabled = optional(bool, false)
    resolution_policy    = optional(string)
    tags                 = optional(map(string))
  }))
  default = {}
}


variable "resource_group_name" {
  description = "Default resource group to be used when not specified at zone level"
  type        = string
}

variable "tags" {
  description = "tags to be added to the resources"
  type        = map(string)
  default     = {}
}
