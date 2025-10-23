
# Function to parse a URL into its components
parse_url() {
  eval "$(echo "$1" | sed -E \
    -e "s#^(([^:]+)://)?(([^:@]+)(:([^@]+))?@)?([^/?]+)(/(.*))?#\
${PREFIX:-URL_}SCHEME='\2' \
${PREFIX:-URL_}USER='\4' \
${PREFIX:-URL_}PASSWORD='\6' \
${PREFIX:-URL_}HOSTPORT='\7' \
${PREFIX:-URL_}DATABASE='\9'#")"
}

# Parse the DATABASE_URL and extract components
PREFIX="MB_DB_" parse_url "$DATABASE_URL"

# Separate host and port
MB_DB_HOST="$(echo "$MB_DB_HOSTPORT" | sed -E 's,:.*,,')"
MB_DB_PORT="$(echo "$MB_DB_HOSTPORT" | sed -E 's,.*:([0-9]+).*,\1,')"

# Export database environment variables
export MB_DB_TYPE="postgres"
export MB_DB_HOST="$MB_DB_HOST"
export MB_DB_PORT="$MB_DB_PORT"
export MB_DB_DBNAME="$MB_DB_DATABASE"
export MB_DB_USER="$MB_DB_USER"
export MB_DB_PASS="$MB_DB_PASSWORD"
