FROM bitnami/minideb

# Set timezone
ENV TZ=Asia/Seoul
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Add Tini
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini
ENTRYPOINT ["/tini", "--"]

# Install cron, pg_dump, and bc
RUN apt-get update && apt-get -y install cron postgresql-client bc

# Setup backup directories
WORKDIR /app
RUN mkdir upload backup

# Register a cronjob
COPY crontab .
RUN crontab crontab && rm crontab

# Add backup scripts
ADD backup-db.sh .
ADD backup-upload.sh .

CMD echo "export PGPASSWORD=$POSTGRES_PASSWORD" > /app/env &&\
    echo "export POSTGRES_USER=$POSTGRES_USER" >> /app/env &&\
    echo "export POSTGRES_HOST=$POSTGRES_HOST" >> /app/env &&\
    echo "export POSTGRES_DB=$POSTGRES_DB" >> /app/env &&\
    touch /tmp/log &&\
    cron &&\
    tail -f /tmp/log
