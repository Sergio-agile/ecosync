# EcoSync Architecture

## What is EcoSync
Local WiFi file sync tool. Runs a Rails server on your laptop and exposes a PWA to manage file transfers between devices without cables, cloud services or app stores.

## Philosophy
- Minimal resources, ecological approach
- No database
- No third party services
- PWA only, no app stores
- On-demand sync, not automatic background sync

## Stack
- Rails 8 API mode, no ActiveRecord
- No database, file indexes generated in memory
- RSpec for testing
- Brakeman for security scanning
- Rubocop for linting

## How it works
Rails server runs locally on the laptop. Mobile opens PWA via local WiFi at the server IP. File indexes (path, size, mtime) are generated on demand and compared to detect changes. Transfers happen directly over local WiFi.

## Use cases
1. Upload new music albums from laptop to mobile
2. Download photos from mobile to laptop

## API Endpoints
- `GET /api/index` - generates file index from ECOSYNC_BASE_PATH
- `POST /api/index/mobile` - compares mobile index with local, returns missing files
- `GET /api/files/*path` - serves a file for download
- `POST /api/files` - receives a file upload

## Security
- Paths sanitized with Pathname.cleanpath
- Validated with start_with? against base_path
- Brakeman ignore file documents the reasoning

## Environment
- `ECOSYNC_BASE_PATH` - base directory to sync (configured in .env, not committed)

## Current status
- Core API implemented and tested
- CI passing (Brakeman, Rubocop, RSpec)
- PWA not started yet

## Pending
- Filter audio extensions in index
- Controller request specs
- PWA interface
- mDNS for device discovery
