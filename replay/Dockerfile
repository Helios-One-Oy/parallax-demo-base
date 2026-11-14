# Parallax replay "image-repoint": harmless simulation of the KICS image tag
# repoint of 22 Apr 2026. The good base image plus one text file. Nothing else.
ARG GOOD
FROM ${GOOD}
COPY --chown=root:root REPOINTED /etc/northbound/REPOINTED
LABEL com.parallax.replay="image-repoint: harmless simulation of the KICS image tag repoint (22 Apr 2026)"
