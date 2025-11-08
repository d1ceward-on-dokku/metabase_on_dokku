![](.github/images/repo_header.png)

[![Metabase](https://img.shields.io/badge/Metabase-0.57.1-blue.svg)](https://github.com/metabase/metabase/releases/tag/v0.57.1)
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

### 3. Configure the Domain and Ports

Set the domain for your app to enable routing:

```bash
dokku domains:set metabase metabase.example.com
```

Map the internal port 3000 to the external port 80:

```bash
dokku proxy:ports-set metabase http:80:3000
```

### 4. Deploy the App

You can deploy the app to your Dokku server using one of the following methods:

#### Option 1: Deploy Using `dokku git:sync`

If your repository is hosted on a remote Git server with an HTTPS URL, you can deploy the app directly to your Dokku server using `dokku git:sync`. This method also triggers a build process automatically. Run the following command:

```bash
dokku git:sync --build metabase https://github.com/d1ceward-on-dokku/metabase_on_dokku.git
```

#### Option 2: Clone the Repository and Push Manually

If you prefer to work with the repository locally, you can clone it to your machine and push it to your Dokku server manually:

1. Clone the repository:

    ```bash
    # Via SSH
    git clone git@github.com:d1ceward-on-dokku/metabase_on_dokku.git

    # Via HTTPS
    git clone https://github.com/d1ceward-on-dokku/metabase_on_dokku.git
    ```

2. Add your Dokku server as a Git remote:

    ```bash
    git remote add dokku dokku@example.com:metabase
    ```

3. Push the app to your Dokku server:

    ```bash
    git push dokku master
    ```

Choose the method that best suits your workflow.

### 7. Enable SSL (Optional)

Secure your app with an SSL certificate from Let's Encrypt:

1. Add the HTTPS port:

    ```bash
    dokku ports:add metabase https:443:9000
    ```

2. Install the Let's Encrypt plugin:

    ```bash
    dokku plugin:install https://github.com/dokku/dokku-letsencrypt.git
    ```

3. Set the contact email for Let's Encrypt:

    ```bash
    dokku letsencrypt:set metabase email you@example.com
    ```

4. Enable Let's Encrypt for the app:

    ```bash
    dokku letsencrypt:enable metabase
    ```

## Wrapping Up

Congratulations! Your Metabase instance is now up and running. You can access it at [https://metabase.example.com](https://metabase.example.com).

Happy data exploring!
