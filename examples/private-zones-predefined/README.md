# Pre Defined Private Dns Zones

This example deploys pre-defined private dns zones.

```hcl
zones = map(object({
  use_predefined_zones = optional(bool, false)
  virtual_network_links = optional(map(object({
    virtual_network_id   = string
    registration_enabled = optional(bool, false)
  })))
}))
```
