# Metabase on Dokku

This repository provides everything you need to run [Metabase](https://github.com/metabase/metabase), an open-source business intelligence and analytics platform, on [Dokku](https://dokku.com/).

## Quick Start (Docker)

To run Metabase locally with Docker:

```bash
docker run -d -p 3000:3000 \
  -e "MB_DB_TYPE=postgres" \
  -e "MB_DB_DBNAME=metabaseappdb" \
  -e "MB_DB_PORT=5432" \
  -e "MB_DB_USER=name" \
  -e "MB_DB_PASS=password" \
  -e "MB_DB_HOST=my-database-host" \
  --name metabase metabase/metabase
```

## Deploying Metabase on Dokku

### 1. Create the App

Log into your Dokku host and create the `metabase` app:

```bash
dokku apps:create metabase
```

### 2. Configure the Database

Install, create, and link a PostgreSQL database to the app:

```bash
# Install PostgreSQL plugin (if not already installed)
dokku plugin:install https://github.com/dokku/dokku-postgres.git postgres

# Create a PostgreSQL instance
dokku postgres:create metabase

# Link the database to the app
dokku postgres:link metabase metabase
```

### 3. Configure Persistent Storage (Optional)

Metabase stores its application data in the database, but you may want to mount a volume for plugins or custom drivers:

```bash
# Example: Mount a plugins directory
dokku storage:ensure-directory metabase-plugins --chown false
dokku storage:mount metabase /var/lib/dokku/data/storage/metabase-plugins:/plugins
```

### 4. Configure the Domain and Ports

Set the domain for your app:

```bash
dokku domains:set metabase metabase.example.com
```

Map the internal port `3000` to the external port `80`:

```bash
dokku ports:set metabase http:80:3000
```

### 5. Deploy the App

You can deploy the app to your Dokku server using one of the following methods:

#### Option 1: Deploy Using `dokku git:sync`

```bash
dokku git:sync --build metabase https://github.com/d1ceward-on-dokku/metabase_on_dokku.git
```

#### Option 2: Clone the Repository and Push Manually

```bash
# Clone the repository
git clone https://github.com/d1ceward-on-dokku/metabase_on_dokku.git
cd metabase_on_dokku

# Add your Dokku server as a remote
git remote add dokku dokku@example.com:metabase

# Push to Dokku
git push dokku master
```

### 6. Enable SSL (Optional)

Secure your app with Let's Encrypt:

```bash
# Install Let's Encrypt plugin (if not already installed)
dokku plugin:install https://github.com/dokku/dokku-letsencrypt.git

# Set contact email
dokku letsencrypt:set metabase email you@example.com

# Enable Let's Encrypt
dokku letsencrypt:enable metabase
```

## Wrapping Up

Your Metabase instance should now be running! Visit [http://metabase.example.com](http://metabase.example.com) (or your configured domain) to get started.

Happy analyzing!
