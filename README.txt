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

	
	
	
	
	
	
	
	
	
	
	
Tests : Les couts 	
•	Les tests unitaires sont en général très simples à mettre en œuvre (à condition de ne pas attendre que le code soit complètement endetté). 
	Fonctionnant en isolation, l’environnement d’exécution est relativement simple à mettre en place (stubs / mocks). 
	Très proches du code, ils sont ensuite naturellement maintenus (à l’aide du refactoring).
•	Les tests d’intégration sont assez simples également (on parle de tests d’intégration au sein d’une application, pas entre applications). 
	On s’affranchit des contraintes majeures (IHM, certaines dépendances). Il sont également assez proches du code, ce qui facilite leur refactoring. 
	Cependant, ils couvrent un spectre plus large de code et de ce fait, ont davantage de risques d’être impactés par une modification.
•	Les tests de bout en bout ou d’IHM sont plus complexes à mettre en œuvre, car ils nécessitent le déploiement d’un environnement complet. 
	La présence des dépendances et les jeux de données sont généralement un casse-tête : instabilités dues à des rechargements depuis la (pré)prod, modifications par d’autres équipes, … 
	Ces éléments rendent ce type de test très fragile et induisent un coût de maintenance important (analyse des builds en erreur, maintien de l’environnement et des données).
	