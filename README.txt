# CATS
Ligne ajouté depuis github

# Prototype de référentiel de paramètres sur Git

*Nota : n'hésitez pas à vous inspirer des scripts présent dans le répertoire `bin` de chaque
        prototype pour voir à quoi ressemblent les commandes `git`, en particulier le script
        `simulate.sh` qui réalise le peuplement initial du projet avec des données de test.*

## Prérequis

Vous devez avoir `git` d'installé pour consulter les dépôts et publier des changements. 

Voici un exemple de fichier `.gitconfig` :

    > cat ~/.gitconfig
    [push]
            default = simple
    [alias]
            graph = log --graph \
                        --abbrev-commit \
                        --decorate \
                        --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' \
                        --all

# Emplacement du prototype

### De quoi s'agit-il

Deux démons git sont présent sur le serveur `dlzadeggsc11`. Cf. le support Powerpoint chacun des deux propose une variante du prototype :
  * le démon qui écoute sur le port 9001 expose le prototype qui correspond à l'option 1 "orientée environnements"
    avec des subtrees et des dépôts par environnement
  * le démon qui écoute sur le port 9002 expose le prototype qui correspond à l'option 2 "orientée squads"
    sans subtree, mais avec des fichiers de type `${ADABO}.yml` dans chaque dépôt

### Quelques informations techniques    

    > hostname
    dlzadeggsc11.yres.ytech

    > sudo netstat -npl  | grep ":900[12]"
    tcp        0      0 0.0.0.0:9001            0.0.0.0:*               LISTEN      21670/git-daemon
    tcp        0      0 0.0.0.0:9002            0.0.0.0:*               LISTEN      21683/git-daemon

    > ps x | grep -v grep | grep "git daemon"
    21669 ?        Ss     0:00 /usr/bin/git daemon --enable=receive-pack --port=9001 --syslog --export-all --reuseaddr --base-path=/home/ETA5436/projets/referentiel_params/option1/repositories /home/ETA5436/projets/referentiel_params/option1/repositories
    21682 ?        Ss     0:00 /usr/bin/git daemon --enable=receive-pack --port=9002 --syslog --export-all --reuseaddr --base-path=/home/ETA5436/projets/referentiel_params/option2/repositories /home/ETA5436/projets/referentiel_params/option2/repositories

	