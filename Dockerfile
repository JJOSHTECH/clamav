# Use a Debian Image
FROM debian:latest

# Update and Upgrade Repo
RUN apt update && apt full-upgrade -y && apt autoremove && apt clean

# Install ClamAV Deamon
RUN apt install clamav clamav-daemon -y

# Configuration Volumes
VOLUME ["/var/lib/clamav/","/etc/clamav/","/etc/systemd/system/clamav-daemon.service.d/"]

# Download Virus Signatures
RUN freshclam

# Copy default clamd configuration into container
COPY ./conf/clamd.conf /etc/clamav/clamd.conf
COPY ./conf/extend.conf /etc/systemd/system/clamav-daemon.service.d/extend.conf

# Expose clamd port
EXPOSE 3310

# Start CLAMAV in foregournd
CMD ["clamd","--foreground=true"]
