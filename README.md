# Audit Système Linux avec Ansible

## Description

Un script Bash pour auditer des serveurs Linux, inialement les machines Debian (mises à jour, services, ports, ressources, logs). Déployé avec **Ansible** et envoi de notifications via **Slack** en cas de problème.

## Installation

- Cloner le dépôt :

    ```bash
    git clone https://github.com/ton-compte/audit-systeme-ansible.git
    cd audit-systeme-ansible
    ```

- Configurer Slack dans `playbook.yml`.

- Ajoute tes hôtes dans `inventory`.

- Lance le playbook :

    ```bash
    ansible-playbook -i inventory playbook.yml
    ```

## Fonctionnalités

- Vérifie les mises à jour, services, ports et ressources.
- Vérifie les logs système.
- Envoie des alertes Slack en cas d’erreur.
