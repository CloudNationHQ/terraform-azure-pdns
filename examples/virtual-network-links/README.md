# Virtual Network Links

This deploys multiple virtual network links for each private dns zone.

## Types

```hcl
zones = map(object({
  name = string
  resourcegroup = string

  virtual_network_links = optional(map(object({
    virtual_network_id   = string
    registration_enabled = bool
  })))
})
```
