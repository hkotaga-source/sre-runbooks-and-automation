# Runbook: High Error Rate / Error Budget Burn

**Severity**: Critical / High  
**Alert**: `HighErrorBudgetBurn` or `HighErrorRate`

## Symptoms
- Spike in 5xx responses
- Error budget burning faster than normal
- Users reporting failures

## Immediate Actions (First 5–10 minutes)

1. **Acknowledge the alert** in PagerDuty / Opsgenie
2. Check the Grafana dashboard: [Link to your Error Rate panel]
3. Identify the top failing endpoints:
   ```promql
   sum by (path, status) (rate(http_requests_total{status=~"5.."}[5m]))
   ```
4. Check recent deployments:
   ```bash
   kubectl rollout history deployment/<your-deployment> -n <namespace>
   ```
5. Look at application logs:
   ```bash
   kubectl logs -l app=<your-app> --tail=200 -n <namespace> | grep -i error
   ```

## Mitigation Options

| Option | Command / Action | Risk |
|--------|------------------|------|
| Rollback last deployment | `kubectl rollout undo deployment/<name>` | Low |
| Scale up replicas | `kubectl scale deployment/<name> --replicas=N` | Low |
| Enable circuit breaker / feature flag | Toggle in config | Medium |
| Redirect traffic (canary off) | Update service or ingress | Medium |

## Communication

- Update status page within 10 minutes
- Post in #incidents Slack channel
- If customer-facing impact > 5%, notify stakeholders

## Post-Incident

- Fill the postmortem template
- Add new alerts or improve existing ones if needed
- Update this runbook with lessons learned
