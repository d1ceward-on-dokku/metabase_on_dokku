
ARG METABASE_VERSION="v0.58.1"

FROM metabase/metabase:${METABASE_VERSION}

COPY ./entrypoint.sh /custom-entrypoint.sh

ENTRYPOINT ["/custom-entrypoint.sh"]
