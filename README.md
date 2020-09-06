# upnl-org-backup [![Docker Status]][Docker Link]

유피넬 홈페이지 디비 및 업로드 폴더 자동 백업 시스템

## Usage

```bash
docker build . -t ghcr.io/upnl/upnl-org-backup
docker run --rm -d \
  -v /path/to/upload:/app/upload \
  -v /path/to/backup:/app/backup \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_HOST=localhost \
  -e POSTGRES_DB=db \
  -e POSTGRES_PASSWORD=somesecretpassword \
  ghcr.io/upnl/upnl-org-backup
```

[Docker Status]: https://badgen.net/badge/icon/docker?icon=docker&label
[Docker Link]: https://github.com/orgs/upnl/packages/container/upnl-org-backup
