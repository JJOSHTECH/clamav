# Use a Debian Image
FROM debian:latest

# Update and Upgrade Repo
RUN apt update && apt full-upgrade -y && apt autoremove && apt clean

# Install ClamAV Deamon
RUN apt install clamav-deamon -y

# Setup clamav with dpkg
RUN dpkg-reconfigure clamav-base
RUN freshcalm

# Copy sshd config to Image
COPY ./conf/sshd_config /etc/ssh/sshd_config

# Start SSH Server in Debug mode
CMD ["/usr/sbin/sshd","-p","22","-D","-e"]

# Expose ssh Port
EXPOSE 22
