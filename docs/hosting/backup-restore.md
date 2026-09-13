---
title: Backup & Restore
icon: lucide/database-backup
---

# Backup & Maintenance :material-database-sync-outline:{ .main-color }

<span class="badge badge-green"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg> Disaster Recovery</span>
<span class="badge badge-cyan"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg> Automated Snapshots</span>
<span class="badge badge-amber"><svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2"><path d="M21 16V8a2 2 0 0 0-1-1.73l-7-4a2 2 0 0 0-2 0l-7 4A2 2 0 0 0 3 8v8a2 2 0 0 0 1 1.73l7 4a2 2 0 0 0 2 0l7-4A2 2 0 0 0 21 16z"></path><polyline points="3.27 6.96 12 12.01 20.73 6.96"></polyline><line x1="12" y1="22.08" x2="12" y2="12"></line></svg> Zero Downtime</span>

Regular backups and predictable maintenance routines ensure your organizational data is safe from hardware failures and software regressions.

---

## :material-database-export-outline: Database Backups (PostgreSQL)

All relational data for identity provider authentication (e.g. Keycloak) and CloudRader application services resides in PostgreSQL.

### 1. Running a Manual Snapshot

To produce an immediate, consistent SQL dump of all databases:

```bash
docker exec -t cloudrader-postgres pg_dumpall -c -U cloudrader | gzip > backup_$(date +%Y%m%d_%H%M%S).sql.gz
```

### 2. Automated Nightly Backup Script

Create a script at `/opt/cloudrader/scripts/backup.sh`:

```bash
#!/usr/bin/env bash
set -euo pipefail

BACKUP_DIR="/opt/cloudrader/backups"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
RETENTION_DAYS=14

mkdir -p "$BACKUP_DIR"

# Perform compressed full database dump
docker exec -t cloudrader-postgres pg_dumpall -c -U cloudrader | gzip > "$BACKUP_DIR/db_$TIMESTAMP.sql.gz"

# Rotate backups older than retention window
find "$BACKUP_DIR" -type f -name "db_*.sql.gz" -mtime +"$RETENTION_DAYS" -delete

echo "[$TIMESTAMP] CloudRader backup completed successfully."
```

Make the script executable:

```bash
chmod +x /opt/cloudrader/scripts/backup.sh
```

### 3. Scheduling with Cron

Add an entry to the host server\'s crontab (`crontab -e`) to trigger every night at 03:00 AM:

```cron
0 3 * * * /opt/cloudrader/scripts/backup.sh >> /var/log/cloudrader_backup.log 2>&1
```

---

## :material-folder-zip-outline: Docker Volume Archives

For complete disaster recovery, periodically archive the underlying Docker storage volumes (containing identity provider files and database indexes):

```bash
# Optional: temporarily pause container activity for cold backup
docker compose stop

# Archive named Docker volumes
tar -czvf /opt/cloudrader/backups/volumes_$(date +%Y%m%d).tar.gz /var/lib/docker/volumes/cloudrader*

# Restart services
docker compose start
```

---

## :material-restore: Disaster Recovery (Restoring Data)

To restore a compressed database backup into a running PostgreSQL container:

```bash
gunzip -c backup_YYYYMMDD_HHMMSS.sql.gz | docker exec -i cloudrader-postgres psql -U cloudrader -d postgres
```

!!! tip "Verifying Restores"
    We strongly recommend periodically restoring backups to an isolated test environment to ensure snapshot integrity.

---

## :material-update: Routine Updates & Maintenance

CloudRader services are designed for zero-downtime or minimal-downtime rolling upgrades.

### 1. Upgrading Service Images

```bash
# 1. Pull latest image versions
docker compose pull

# 2. Recreate containers with updated images
docker compose up -d --remove-orphans
```

### 2. Automatic Schema Migrations

CloudRader services handle database schema evolution automatically on startup:

- **Reservium API**: Runs Alembic migrations at container boot before accepting HTTP traffic.
- **Inventarium API**: Executes Liquibase change logs during Spring Boot initialization.

### 3. Cleaning Unused Docker Resources

Remove orphaned container layers and unused images to recover disk space:

```bash
docker image prune -f
```
