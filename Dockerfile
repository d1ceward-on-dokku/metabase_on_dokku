
ARG METABASE_VERSION="v0.56.12"

FROM metabase/metabase:${METABASE_VERSION}

COPY ./entrypoint.sh /custom-entrypoint.sh

ENTRYPOINT ["/custom-entrypoint.sh"]
