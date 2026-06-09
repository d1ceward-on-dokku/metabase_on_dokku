
ARG METABASE_VERSION="v0.62.1"

FROM metabase/metabase:${METABASE_VERSION}

COPY ./entrypoint.sh /custom-entrypoint.sh

ENTRYPOINT ["/custom-entrypoint.sh"]
