ARG PG_MAJOR
FROM ghcr.io/cloudnative-pg/postgresql:$PG_MAJOR

LABEL org.opencontainers.image.authors="Tobias Florek <me@ibotty.net>" \
      org.opencontainers.source=https://github.com/ibotty/postgresql-related-packages \
      org.opencontainers.image.description="Builder to build some PostgreSQL extensions and FDWs"

ENTRYPOINT ["/bin/bash"]

ENV PACKAGES="git build-essential curl pkg-config cmake flex bison xsltproc ccache clang gcc tree unzip ninja-build"

USER 0

RUN sed 's/^deb/deb-src/' /etc/apt/sources.list.d/pgdg.list  > /etc/apt/sources.list.d/pgdg-src.list \
 && apt-get update \
 && apt-get dist-upgrade -y -o Dpkg::Options::=--force-confnew \
 && apt-get build-dep -y postgresql-server-dev-$PG_MAJOR \
 && apt-get install -y --no-install-recommends $PACKAGES \
 && apt-get install -y --no-install-recommends postgresql-server-dev-$PG_MAJOR \
 && apt-get clean \
 && for pg_config in /usr/lib/postgresql/*/bin/pg_config; do \
      mkdir -p $($pg_config --sharedir)/extension; \
      chmod a+rwx $($pg_config --pkglibdir) $($pg_config --sharedir)/extension; \
    done \
 && chmod a+rwx /var/run/postgresql \
 && echo 'github::1001:1001:GitHub actions user:/home/github:/bin/bash' >> /etc/passwd
