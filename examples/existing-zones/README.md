# Existing Zones

This deploys existing private dns zones using a provider alias.

## Types

```hcl
zones = map(object({
  name           = string
  resource_group = string

  use_existing_zone = optional(bool)
  virtual_network_links = optional(map(object({
    virtual_network_id   = string
    registration_enabled = bool
  })))
}))
```

## Notes

An additional provider block is required to establish the alias.
