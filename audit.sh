#!/bin/bash

LOG_FILE="/var/log/system_audit.log"
VERSION="1.0.0"

log_message() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" >> $LOG_FILE
}

notify_success() {
    curl -X POST -H 'Content-type: application/json' --data '{"text":"Audit terminé avec succès."}' $SLACK_WEBHOOK_URL
}

notify_failure() {
    curl -X POST -H 'Content-type: application/json' --data '{"text":"Problème détecté dans l'audit."}' $SLACK_WEBHOOK_URL
}

# Vérification de mise à jour
echo "### Vérification des mises à jour ###"
apt list --upgradable
if [ $? -ne 0 ]; then
    log_message "Erreur."
    notify_failure
    exit 1
fi
log_message "Succès."

# Analyse des services actifs
echo "### Services actifs ###"
ps -aux
log_message "Services vérifiés."

# Liste des ports ouverts
echo "### Ports ouverts  ###"
if command -v ss &>/dev/null; then
    ss -tuln
else
    echo "Problème lors de la récupération."
fi
log_message "Ports ouverts vérifiés."

# Analyse de l'utilisation des composants
echo "### Utilisation des ressources ###"
top -b -n1 | head -n 10
df -h
log_message "Analyse des ressources effectués."

# Vérification des logs
echo "### Vérification des logs ###"
if [ -f /var/log/syslog ]; then
    tail -n 10 /var/log/syslog
else
    echo "Fichier syslog introuvable. Journaux désactivés."
fi
log_message "Logs vérifiés."

# Vérification de l'espace disque
echo "### Vérification de l'espace disque ###"
df -h
local threshold=80
local usage=$(df / | grep / | awk '{ print $5 }' | sed 's/%//g')
if [ $usage -gt $threshold ]; then
    echo "Attention : L'espace disque est supérieur à $threshold% ($usage%)"
fi
log_message "Espace disque vérifié."

# Vérification des mises à jour de sécurité
echo "### Vérification des mises à jour de sécurité ###"
apt list --upgradable | grep -i security
log_message "Mises à jour de sécurité vérifiées."

# Envoi de notification en cas d'échec de l'audit
if [[ $(check_some_condition) == "failure" ]]; then
  curl -X POST -H 'Content-type: application/json' --data '{"text":"A problem was detected in the audit."}' $SLACK_WEBHOOK_URL
fi

# Envoi de notification de succès
notify_success
log_message "Audit terminé"
