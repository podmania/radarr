# radarr

Usenet/BitTorrent movie downloader.

Upstream: [Radarr/Radarr](https://github.com/Radarr/Radarr)  
Documentation: [wiki.servarr.com/en/radarr](https://wiki.servarr.com/en/radarr)

## Ports

- `7878` — Web UI

## Volumes

- `/config` — Configuration, database, logs

## Environment Variables

Variables use the format `RADARR__<SECTION>__<KEY>` (double underscores, case-sensitive). They override `config.xml` entries and require a restart to take effect.

### App

| Variable | Default | Description |
| --- | --- | --- |
| `RADARR__APP__INSTANCENAME` | `Radarr` | Instance display name |
| `RADARR__APP__THEME` | `auto` | UI theme: `auto`, `light`, `dark` |
| `RADARR__APP__LAUNCHBROWSER` | `true` | Launch browser on start |

### Auth

| Variable | Default | Description |
| --- | --- | --- |
| `RADARR__AUTH__APIKEY` | _(auto-generated)_ | API key for external access |
| `RADARR__AUTH__ENABLED` | `false` | (Legacy) Enable authentication |
| `RADARR__AUTH__METHOD` | `None` | Auth method: `None`, `Forms` |
| `RADARR__AUTH__REQUIRED` | `Enabled` | When auth is required: `Enabled`, `DisabledForLocalAddresses` |
| `RADARR__AUTH__TRUSTCGNATIPADDRESSES` | `false` | Trust CGNAT IP addresses for auth bypass |

### Server

| Variable | Default | Description |
| --- | --- | --- |
| `RADARR__SERVER__PORT` | `7878` | HTTP port |
| `RADARR__SERVER__BINDADDRESS` | `*` | IP to bind to |
| `RADARR__SERVER__URLBASE` | _(empty)_ | URL base for reverse proxy (e.g. `/radarr`) |
| `RADARR__SERVER__ENABLESSL` | `false` | Enable HTTPS |
| `RADARR__SERVER__SSLPORT` | `9898` | HTTPS port |
| `RADARR__SERVER__SSLCERTPATH` | _(empty)_ | Path to SSL certificate (.pfx) |
| `RADARR__SERVER__SSLCERTPASSWORD` | _(empty)_ | SSL certificate password |

### Log

| Variable | Default | Description |
| --- | --- | --- |
| `RADARR__LOG__LEVEL` | `debug` | File log level: `trace`, `debug`, `info`, `warn`, `error`, `fatal` |
| `RADARR__LOG__CONSOLELEVEL` | _(empty)_ | Console log level |
| `RADARR__LOG__CONSOLEFORMAT` | `Standard` | Console log format: `Standard`, `Ansi` |
| `RADARR__LOG__ANALYTICSENABLED` | `true` | Send anonymous usage data |
| `RADARR__LOG__FILTERSENTRYEVENTS` | `true` | Filter Sentry error reports |
| `RADARR__LOG__LOGSQL` | `false` | Log SQL queries |
| `RADARR__LOG__ROTATE` | `50` | Number of log files to keep |
| `RADARR__LOG__SIZELIMIT` | `1` | Max log file size in MB (0–10) |
| `RADARR__LOG__DBENABLED` | `true` | Enable the log database |
| `RADARR__LOG__SYSLOGSERVER` | _(empty)_ | Syslog server hostname |
| `RADARR__LOG__SYSLOGPORT` | `514` | Syslog server port |
| `RADARR__LOG__SYSLOGLEVEL` | _(same as Level)_ | Syslog log level |

### PostgreSQL

| Variable | Default | Description |
| --- | --- | --- |
| `RADARR__POSTGRES__HOST` | _(empty = SQLite)_ | PostgreSQL server hostname |
| `RADARR__POSTGRES__PORT` | `5432` | PostgreSQL server port |
| `RADARR__POSTGRES__USER` | _(empty)_ | PostgreSQL username |
| `RADARR__POSTGRES__PASSWORD` | _(empty)_ | PostgreSQL password |
| `RADARR__POSTGRES__MAINDB` | `radarr-main` | Main database name |
| `RADARR__POSTGRES__LOGDB` | `radarr-log` | Log database name |

### Update

| Variable | Default | Description |
| --- | --- | --- |
| `RADARR__UPDATE__MECHANISM` | `BuiltIn` | Update method: `BuiltIn`, `Script`, `External`, `Docker` |
| `RADARR__UPDATE__AUTOMATICALLY` | _(platform default)_ | Auto-install updates |
| `RADARR__UPDATE__SCRIPTPATH` | _(empty)_ | Path to custom update script |
| `RADARR__UPDATE__BRANCH` | `master` | Update branch: `master`, `develop`, `nightly` |
