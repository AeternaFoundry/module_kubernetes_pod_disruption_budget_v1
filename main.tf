resource "kubernetes_pod_disruption_budget_v1" "pod_disruption_budget_v1s" {
  for_each = var.pod_disruption_budget_v1s


  metadata {
    annotations   = each.value.metadata.annotations
    generate_name = each.value.metadata.generate_name
    labels        = each.value.metadata.labels
    name          = each.value.metadata.name
    namespace     = each.value.metadata.namespace
  }

  spec {
    max_unavailable = each.value.spec.max_unavailable
    min_available   = each.value.spec.min_available
    selector {
      dynamic "match_expressions" {
        for_each = each.value.spec.selector.match_expressions != null ? each.value.spec.selector.match_expressions : []
        content {
          key      = match_expressions.value.key
          operator = match_expressions.value.operator
          values   = match_expressions.value.values
        }
      }
      match_labels = each.value.spec.selector.match_labels
    }
  }
}

