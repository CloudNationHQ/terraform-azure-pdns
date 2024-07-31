# Records

This deploys different types of private dns zone records.

## Types

```hcl
zones = map(object({
  name = string
  resourcegroup = string

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
}))
```
