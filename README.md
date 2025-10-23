![](.github/images/repo_header.png)

[![Metabase](https://img.shields.io/badge/Metabase-0.56.11-blue.svg)](https://github.com/metabase/metabase/releases/tag/v0.56.11)
[![Dokku](https://img.shields.io/badge/Dokku-Repo-blue.svg)](https://github.com/dokku/dokku)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/d1ceward-on-dokku/minio_on_dokku/graphs/commit-activity)
# Run Metabase on Dokku

## Overview

This guide provides instructions on how to deploy Metabase, an open-source business intelligence tool, on a [Dokku](http://dokku.viewdocs.io/dokku/) server using a custom Dockerfile.

## Prerequisites

Before proceeding, ensure you have the following:

- A working [Dokku host](http://dokku.viewdocs.io/dokku/getting-started/installation/).
- The [PostgreSQL plugin](https://github.com/dokku/dokku-postgres) installed on Dokku.
- (Optional) The [Let's Encrypt plugin](https://github.com/dokku/dokku-letsencrypt) for SSL certificates.

## Setup Instructions

### 1. Create the App

Log into your Dokku host and create the `metabase` app:

```bash
dokku apps:create metabase
```

### 2. Configure the App

#### Install, Create, and Link PostgreSQL Plugin

1. Install the PostgreSQL plugin:

    ```bash
    dokku plugin:install https://github.com/dokku/dokku-postgres.git postgres
    ```

2. Create a PostgreSQL service:

    ```bash
    dokku postgres:create metabase
    ```

3. Link the PostgreSQL service to the app:

    ```bash
    dokku postgres:link metabase metabase
    ```
