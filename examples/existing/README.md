# Existing Zones

This deploys existing private dns zones using a provider alias.

## Types

```hcl
zones = object({
  private = map(object({
    name              = string
    use_existing_zone = optional(bool)
    virtual_network_links = optional(map(object({
      virtual_network_id   = string
      registration_enabled = optional(bool)
    })))
  }))
})
```

## Notes

An additional provider block is required to establish the alias.
