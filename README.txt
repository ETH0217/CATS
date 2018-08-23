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

