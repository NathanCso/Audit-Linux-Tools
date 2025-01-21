FROM debian:latest

# Mettre à jour les paquets et installer les paquets nécessaires
RUN apt-get update && apt-get install -y \
    curl \
    bash \
    net-tools \         
    procps \           
    systemd \           
    rsyslog \          
    iproute2 && \      
    rm -rf /var/lib/apt/lists/*

# Copier le script audit.sh dans le conteneur
COPY audit.sh /audit.sh

# Rendre le script exécutable
RUN chmod +x /audit.sh

# Définir le point d'entrée pour exécuter le script
CMD ["bash", "/audit.sh"]
