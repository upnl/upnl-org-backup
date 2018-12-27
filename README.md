# upnl-org-backup

유피넬 홈페이지 디비 및 업로드 폴더 자동 백업 시스템

## Usage

```bash
$ docker build . -t upnl-org-backup
$ docker run --rm -d \
  -v /path/to/upload:/app/upload \
  -v /path/to/backup:/app/backup \
  -e POSTGRES_USER=postgres \
  -e POSTGRES_HOST=localhost \
  -e POSTGRES_DB=db \
  -e POSTGRES_PASSWORD=somesecretpassword \
  upnl-org-backup
```
