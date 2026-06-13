# TechHub Scripts

These are the two automation scripts used in Phase 4 of the TechHub Infrastructure Project.

## Scripts

### backup_system.sh
Compresses the `/var/www` directory into a timestamped `.tar.gz` archive and logs a SHA256 hash for integrity verification.

**Install:**
```bash
sudo cp backup_system.sh /usr/local/bin/
sudo chmod +x /usr/local/bin/backup_system.sh
```

**Cron schedule (runs every night at 2AM):**
```
0 2 * * * /usr/local/bin/backup_system.sh
```

**Log file:** `/var/log/backup_audit.log`

---

### health_check.sh
Checks if Apache2, BIND9, and Samba are running. Logs OK or WARNING for each.

**Install:**
```bash
sudo cp health_check.sh /usr/local/bin/
sudo chmod +x /usr/local/bin/health_check.sh
```

**Cron schedule (runs every 5 minutes):**
```
*/5 * * * * /usr/local/bin/health_check.sh
```

**Log file:** `/var/log/service_health.log`

---

## Setting up Cron

```bash
sudo crontab -e
```

Add both lines:
```
0 2 * * * /usr/local/bin/backup_system.sh
*/5 * * * * /usr/local/bin/health_check.sh
```

Verify with:
```bash
sudo crontab -l
```
