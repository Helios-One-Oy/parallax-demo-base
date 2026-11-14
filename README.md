# Northbound Dispatch — base image

The company base image for Northbound Dispatch Node services
(`ghcr.io/helios-one-oy/parallax-demo-base:22`, private). Part of the Parallax fleet:
it is built and pushed only by a job on a CRACI runner, so CRACI records which job
produced every manifest and layer.

Use it:

```
FROM ghcr.io/helios-one-oy/parallax-demo-base:22
```

It is `mirror.gcr.io/library/node:22-slim` plus `NODE_ENV=production`, `TZ=UTC`,
`WORKDIR /app`, `USER node` and two text files under `/etc/northbound`. Nothing is
fetched while the image is built.

## Workflows

| Workflow | Runs on | What |
|---|---|---|
| `image` | CRACI | Builds the image and pushes `:22` and `:<commit sha>`. A second job (`consumer`) logs in to ghcr.io with the job token and builds `FROM` the tag, to prove a CRACI build can pull the private image. Start it by hand with `build` off to run only the consumer. |
| `replay image-repoint` | GitHub-hosted | Attack replay (KICS image, 22 Apr 2026). Pushes the good image plus one text file over `:22` from outside CRACI. Harmless. |
| `restore good image` | GitHub-hosted | Puts `:22` back on the last image our CRACI job built, and only if CRACI's provenance names one of our jobs for that digest. |

After a repoint, run `image` with `build` off: the consumer pulls `:22` on a CRACI
runner and gets a digest that no CRACI job of ours produced. Parallax (`images`)
reports that pull.
