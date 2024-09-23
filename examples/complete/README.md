# Complete

This example highlights the complete usage.

## Types

```hcl
zones = map(object({
  name              = string
  resource_group    = string
  use_existing_zone = optional(bool)

  records = optional(object({
    a = optional(map(object({
      name    = string
      ttl     = number
      records = list(string)
    })))
    cname = optional(map(object({
      name   = string
      ttl    = number
      record = string
    })))
    srv = optional(map(object({
      name = string
      ttl  = number
      records = map(object({
        priority = number
        weight   = number
        port     = number
        target   = string
      }))
    })))
    txt = optional(map(object({
      name    = string
      ttl     = number
      records = list(string)
    })))
    ptr = optional(map(object({
      name    = string
      ttl     = number
      records = list(string)
    })))
  }))
  virtual_network_links = optional(map(object({
    virtual_network_id = string
  })))
}))
```
