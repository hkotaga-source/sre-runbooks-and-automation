#!/usr/bin/env bash
# Simple post-incident report generator

set -euo pipefail

INCIDENT_ID=${1:-"INC-XXXX"}
DATE=$(date +%Y-%m-%d)

cat << EOF
# Postmortem: $INCIDENT_ID
**Date**: $DATE  
**Author**: $(whoami)  
**Severity**:  

## Summary
<!-- 2-3 sentence overview of what happened -->

## Impact
- Duration: 
- Users affected: 
- Revenue / SLA impact: 

## Timeline
| Time (UTC) | Event |
|------------|-------|
|            | Alert fired |
|            | Engineer acknowledged |
|            | Mitigation applied |
|            | Incident resolved |

## Root Cause
<!-- What actually caused it -->

## What Went Well
- 

## What Went Poorly
- 

## Action Items
| Action | Owner | Due Date | Status |
|--------|-------|----------|--------|
|        |       |          |        |

## Lessons Learned
- 
EOF

echo "Postmortem template generated for $INCIDENT_ID"
