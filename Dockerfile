# Northbound Dispatch base image for Node services.
# Only COPY/ENV/USER lines: nothing is fetched while the image is built, so every
# byte in it is either the upstream Node image or a file prepared on the CRACI runner.
FROM mirror.gcr.io/library/node:22-slim
LABEL org.opencontainers.image.source="https://github.com/Helios-One-Oy/parallax-demo-base" \
      org.opencontainers.image.title="Northbound Dispatch Node base" \
      org.opencontainers.image.description="Company base image for Northbound Dispatch Node services (demo fleet for Parallax)."
ENV NODE_ENV=production \
    TZ=UTC
COPY rootfs/ /
WORKDIR /app
USER node
