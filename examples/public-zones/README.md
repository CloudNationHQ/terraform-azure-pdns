# Public Dns Zones

This example deploys public dns zones and records.

## Types

```hcl
zones = object({
  public = map(object({
    name = string
    records = optional(object({
      a = optional(map(object({
        name    = string
        ttl     = number
        records = list(string)
      })))
      aaaa = optional(map(object({
        name    = string
        ttl     = number
        records = list(string)
      })))
      cname = optional(map(object({
        name   = string
        ttl    = number
        record = string
      })))
      mx = optional(map(object({
        name = string
        ttl  = number
        records = list(object({
          preference = number
          exchange   = string
        }))
      })))
      txt = optional(map(object({
        name    = string
        ttl     = number
        records = list(string)
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
      caa = optional(map(object({
        name = string
        ttl  = number
        records = list(object({
          flags = number
          tag   = string
          value = string
        }))
      })))
    }))
    soa_record = optional(object({
      email         = string
      ttl           = number
      expire_time   = number
      retry_time    = number
      minimum_ttl   = number
      refresh_time  = number
      serial_number = number
      tags         = optional(map(string))
    }))
  }))
})
```
