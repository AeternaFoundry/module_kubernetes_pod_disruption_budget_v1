variable "pod_disruption_budget_v1s" {
  description = <<EOT
Map of pod_disruption_budget_v1s, attributes below
Required:
    - metadata (block):
        - annotations (optional)
        - generate_name (optional)
        - labels (optional)
        - name (optional)
        - namespace (optional)
    - spec (block):
        - max_unavailable (optional)
        - min_available (optional)
        - selector (required, block):
            - match_expressions (optional, block):
                - key (optional)
                - operator (optional)
                - values (optional)
            - match_labels (optional)
EOT

  type = map(object({
    metadata = object({
      annotations   = optional(map(string))
      generate_name = optional(string)
      labels        = optional(map(string))
      name          = optional(string)
      namespace     = optional(string)
    })
    spec = object({
      max_unavailable = optional(string)
      min_available   = optional(string)
      selector = object({
        match_expressions = optional(list(object({
          key      = optional(string)
          operator = optional(string)
          values   = optional(set(string))
        })))
        match_labels = optional(map(string))
      })
    })
  }))
  # Note: 2 additional provider-side validators are enforced at apply time but not mirrored as validation{} blocks here (bespoke or non-mechanically-translatable).
}

