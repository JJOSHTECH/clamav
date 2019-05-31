# Use a Debian Image
FROM arm32v7/debian:stretch-slim

#ARM Support
COPY qemu-arm-static /usr/bin

# Update and Upgrade Repo
RUN apt update && apt full-upgrade -y && apt autoremove && apt clean

# Install ClamAV Deamon
RUN apt install clamav clamav-daemon -y

# Configuration Volumes
VOLUME ["/var/lib/clamav/","/etc/clamav/","/etc/systemd/system/clamav-daemon.service.d/"]

# Copy default clamd configuration into container
COPY ./conf/clamd.conf /etc/clamav/clamd.conf
COPY ./conf/extend.conf /etc/systemd/system/clamav-daemon.service.d/extend.conf

#Copy Cronjob File into Container
COPY cronjob /etc/cron.d/cronjob

# ADD startUP.sh script into container and make runable
COPY ./startUP.sh ./startUP.sh
RUN chmod +x ./startUP.sh

# Expose clamd port
EXPOSE 3310

# Start Update Virus Database and CLAMAV in foregournd
ENTRYPOINT ["./startUP.sh"]
CMD ["clamav"]
