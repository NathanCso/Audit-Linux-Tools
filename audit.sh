#!/bin/bash

#Verification des mises a jour 

echo "### Vérification des mises à jour ###"
apt list --upgradable

#Analyse des services actifs
echo "### Services actifs ###"
ps -aux

#Faire une liste des ports ouverts
echo "### Ports ouverts  ###" 
echo "### Ports ouverts ###"
if command -v ss &>/dev/null; then
    ss -tuln
else
    echo "Ni ss ni netstat ne sont disponibles."
fi

#Analyse de l'utilisation des composants 
echo "### Utilisation des ressources ###"
top -b -n1 | head -n 10
df -h

#Verification des logs 
echo "### Utilisation des ressources ###"
if [ -f /var/log/syslog ]; then
    tail -n 10 /var/log/syslog
else
    echo "Fichier syslog introuvable. Journaux désactivés."
fi
