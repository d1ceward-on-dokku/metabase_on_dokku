
ARG METABASE_VERSION="v0.65.2"

FROM metabase/metabase:${METABASE_VERSION}

COPY ./entrypoint.sh /custom-entrypoint.sh

ENTRYPOINT ["/custom-entrypoint.sh"]
