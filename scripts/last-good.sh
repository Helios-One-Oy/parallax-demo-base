#!/usr/bin/env bash
# Print the commit SHA of the newest run of the "image" workflow whose "image" job
# succeeded. That commit's tag (ghcr.io/helios-one-oy/parallax-demo-base:<sha>) is
# the last base image a CRACI job of ours built. Needs GH_TOKEN with actions: read.
set -euo pipefail
repo="${GITHUB_REPOSITORY:-Helios-One-Oy/parallax-demo-base}"
for id in $(gh run list -R "$repo" --workflow image.yml -L 30 --json databaseId --jq '.[].databaseId'); do
  ok=$(gh run view "$id" -R "$repo" --json jobs --jq '[.jobs[] | select(.name == "image") | .conclusion] | first // ""')
  if [ "$ok" = "success" ]; then
    gh run view "$id" -R "$repo" --json headSha --jq .headSha
    exit 0
  fi
done
echo "no run of image.yml with a successful image job found" >&2
exit 1
