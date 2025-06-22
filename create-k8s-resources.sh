#!/usr/bin/env bash

curl -L \
  -X POST \
  -H "Accept: application/vnd.github.v3+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  "https://api.github.com/repos/sayfelanjos/self_managed-k8s-cluster-on-azure /dispatches" \
  -d '{"event_type": "create-resources"}'
