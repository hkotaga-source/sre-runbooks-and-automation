# Runbook: Pod CrashLoopBackOff

**Severity**: Warning → Critical (if widespread)

## Quick Diagnosis

```bash
# See which pods are crashing
kubectl get pods -A | grep CrashLoopBackOff

# Describe the pod
kubectl describe pod <pod-name> -n <namespace>

# Check previous logs (very important)
kubectl logs <pod-name> -n <namespace> --previous
```

## Common Causes & Fixes

1. **Bad configuration / missing secret**
   - Check env vars and mounted secrets
2. **Application panic / unhandled exception**
   - Look at `--previous` logs
3. **Resource limits too low (OOMKilled)**
   - Check `kubectl describe` → Last State
4. **Liveness probe too aggressive**
   - Temporarily increase `initialDelaySeconds` or `failureThreshold`

## Commands Cheat Sheet

```bash
# Restart a deployment
kubectl rollout restart deployment/<name> -n <namespace>

# Delete the crashing pod (let it recreate)
kubectl delete pod <pod-name> -n <namespace>

# Check events
kubectl get events -n <namespace> --sort-by='.lastTimestamp'
```
