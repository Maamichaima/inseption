#!bin/bash

mkdir -p /var/run/vsftpd/empty

#Config file !!!!
cat <<EOF > /etc/vsftpd.conf

listen=YES
anonymous_enable=NO
local_enable=YES
write_enable=YES
pasv_enable=YES
pasv_min_port=30000
pasv_max_port=30009
local_root=/var/www/html
chroot_local_user=NO
secure_chroot_dir=/var/run/vsftpd/empty

EOF

# 🔹 Quand ces ports sont-ils utilisés ?
# Étape 1 : Le client se connecte au port 21 (connexion de contrôle).

# Étape 2 : Le client envoie une commande (ex: LIST, GET).

# Étape 3 : Le serveur répond :
# "Utilise le port 30004 pour les données" (dans la plage 30000-30009).

# Étape 4 : Le client initie une nouvelle connexion vers ce port.

#create user + set password
# Creating an FTP user lets someone securely log in and manage files on your server via FTP, using the credentials you set.
useradd -m ${FTP_USER}
echo "${FTP_USER}:${FTP_PASS}" | chpasswd

#start ftp server 
/usr/sbin/vsftpd /etc/vsftpd.conf