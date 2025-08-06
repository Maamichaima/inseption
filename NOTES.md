# 📘 Project Notes

## 🧩 Project Name
> A short description of what this project does.

**My INCEPTION Setup**

infrastructure-project/
├── docker-compose.yml
├── Makefile
└── requirements/
    └── nginx/
        ├── Dockerfile
        ├── nginx.conf
        ├── default.conf
        ├── tools/
        │   ├── server.crt <--- Proves the server's identity to users. Like a passport.
        │   └── server.key <--- Secret key used to encrypt and decrypt data. Must be kept private on the server!
        └── html/
            └── index.html
	└── wordpress/
        ├── Dockerfile
        └── conf.d/
            └── php-fpm.conf
	└── mariadb/
        ├── Dockerfile
        └── my.cnf   (optional config)


# TSL (Transport Layer Security)

un protocole de sécurité qui permet de chiffrer les communications entre :

* Ton navigateur (comme Chrome ou Firefox)
* Et un serveur web (comme NGINX)

🔑 TLS, c’est le remplaçant de SSL
Tu as peut-être entendu parler de SSL (Secure Sockets Layer) ?
Aujourd’hui on utilise TLS, qui est plus moderne et sécurisé Mais les gens disent encore “certificat SSL” par habitude, même si c’est du TLS 

🔄 How These Work Together (Simple Explanation)
When a browser connects to your server:

1- NGINX sends server.crt (the certificate) to the browser.

2- The browser checks if the certificate is valid (trusted issuer, right domain, not expired).

3- Then, they use this information to agree on a secure encryption.

4- server.key is used by NGINX to decrypt what the browser sends securely.

## 🧭 Partie 1 : Schéma visuel — Comment NGINX utilise TLS

[🌍 Client navigateur]
     |
     | 1️⃣ Client Hello (versions TLS, chiffrements, etc.)
     |
     v
[🔒 NGINX serveur]
     |
     | 2️⃣ Server Hello + Certificat TLS (.crt)
     |
     v
[🌍 Client vérifie le certificat] 🔍
     |
     | 3️⃣ Échange de clés (ex: ECDHE)
     |
     v
[🔒 NGINX et Client génèrent la clé secrète]
     |
     | 4️⃣ Messages "Finished" chiffrés
     |
     v
[🔐 Connexion sécurisée établie 🔁 via HTTPS]
     |
     | ✅ Toutes les données sont chiffrées
     |
     v
[🌍 Client reçoit la page web sécurisée !]

### generat a Certificat and key

openssl req -x509 -nodes -days 365 \
  -newkey rsa:2048 \
  -keyout selfsigned.key \
  -out selfsigned.crt \
  -subj "/C=FR/ST=IDF/L=Paris/O=MySite/CN=localhost"


# 🛜 Docker Networking (Without Docker Compose)

## 🧩 Default Behavior: Docker Bridge Network

When you run Docker containers **without specifying a network**, Docker does this:

- Puts all containers on the **default bridge network**
- Gives each container a **fake IP address** (e.g., `172.17.0.2`)
- Containers **can talk to each other using IP addresses**
- But... they **can’t use names** like `web`, `db`, etc.


## 🧠 Custom Bridge Network

If you create your **own bridge network**, Docker helps you more:

Now let’s say you create your own special bridge.
Docker says:
“Nice! Now I’ll also let your toy computers learn each other’s names!”
Now "web" can just say:
“Hey, db, are you there?”
And Docker will answer:
“Yes! db is at 172.18.0.3 — go talk to it!”


## ⚙️ What About Docker Compose?

When you use Docker Compose, and you don’t specify any network, Docker Compose:
 - Creates a custom bridge network automatically
 - Assigns your services to it
 - Enables name-based communication out of the box!

Docker Compose secretly does this:
“Hmm... you didn’t tell me which network to use. I’ll create a special bridge just for this project!”


khaseni n configuri php fpm bach ilistni 3la l port 9000 hit hwa li kansifto lih dakechi dyal phpfpm 



mn mora configuri wordpress bach ikhdem b maria db (mariadb khas deja tcrere fiha user odakechi ikon wajed )


## test ftp 

we need to install ftp client like filezilla 
Or use lftp in terminal: Install lftp if needed:
 - brew install lftp
then  connect
 - lftp -u $FTP_USER,$FTP_PASS localhost

If you connect and see files from /var/www/html, your FTP server works!

Ports utilisés :
Port 21 (connexion contrôle toujour utiliser).
Port 20 (transfert de données en mode actif).

🔹 Mode Actif (PORT)
Client se connecte au port 21 du serveur (contrôle).
Client dit : "Je suis sur le port X, envoie-moi les données !"
Serveur initie une connexion depuis son port 20 vers le port X du client.
→ Problème : Si le client a un firewall, la connexion peut être bloquée.

🔹 Mode Passif (PASV)
Client se connecte au port 21 (contrôle).
Serveur répond : "Utilise le port Y pour les données"
Client initie une nouvelle connexion vers le port Y du serveur.
→ Avantage : Passe mieux à travers les firewalls (le client initie tout).


# how docker commande work 
Toi (terminal) (docker run , down , up ,....)
    ↓
Docker CLI → Docker Daemon → containerd → runc → Le conteneur tourne 🎉
