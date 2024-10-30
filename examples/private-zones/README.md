# Private Dns Zones

This example deploys private dns zones and records.

## Types

```hcl
zones = object({
  private = map(object({
    name = string
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
})
```
