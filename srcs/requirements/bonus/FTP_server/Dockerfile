FROM debian:12.11

# - `vsftpd`: Very Secure FTP Daemon, the FTP server
# - `ftp`: FTP client for testing

RUN apt-get update -y && apt-get install -y vsftpd ftp

COPY ./tools/scriptFtp.sh /script.sh

RUN chmod +x /script.sh

RUN mkdir -p /var/run/vsftpd/empty

CMD [ "/script.sh" ]