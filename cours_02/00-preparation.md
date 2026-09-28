# 00 - Préparation

> Durée : environ 10 minutes en séance, **si le reste a été fait avant**. Sous Windows, prévoyez 15 à 20 minutes supplémentaires en amont.

Trois choses à mettre en place : un compte Claude, un terminal qui fonctionne, et les fichiers du cours.

## 1. Créer un compte Claude

Pendant la séance, vous demanderez de l'aide à Claude, une IA conversationnelle.

1. Rendez-vous sur [claude.ai](https://claude.ai).
2. Créez un compte avec votre adresse e-mail (ou un compte Google), puis confirmez votre adresse si un e-mail vous le demande.
3. Un compte gratuit suffit pour la séance.
4. Gardez Claude ouvert dans un onglet du navigateur, à côté de votre terminal.

> [!WARNING]
> N'envoyez jamais à Claude de mots de passe, de données personnelles ni de documents confidentiels. Pour ce cours, vous n'aurez besoin que de textes littéraires du domaine public.

## 2. Ouvrir un terminal

Selon votre système :

### Linux

Ouvrez l'application **Terminal** (souvent avec le raccourci `Ctrl` + `Alt` + `T`).

Si `git` ou `curl` ne sont pas installés, tapez (sous Ubuntu et Debian) :

```bash
sudo apt update && sudo apt install -y git curl
```

Le système vous demande votre mot de passe. **Il n'apparaît pas à l'écran quand vous le tapez** : c'est normal, tapez-le quand même et validez avec `Entrée`.

### Mac

Ouvrez **Terminal** : appuyez sur `Cmd` + `Espace`, tapez « Terminal », puis `Entrée`.

La première fois que vous utiliserez `git`, macOS peut proposer d'installer les « outils de ligne de commande ». Acceptez : l'installation prend quelques minutes.

### Windows : installer WSL

Windows n'a pas de vrai terminal bash. On installe donc **WSL** (*Windows Subsystem for Linux*), qui fait tourner Linux à l'intérieur de Windows. Il faut Windows 10 (version 2004 ou plus récente) ou Windows 11.

1. Ouvrez **PowerShell en administrateur** : clic droit sur le bouton Démarrer, puis « Terminal (administrateur) » ou « Windows PowerShell (administrateur) » selon votre version.
2. Tapez la commande suivante, puis `Entrée` :

   ```powershell
   wsl --install
   ```

3. Attendez la fin de l'installation, puis **redémarrez l'ordinateur**.
4. Au redémarrage, une fenêtre **Ubuntu** s'ouvre et termine l'installation (quelques minutes). Elle vous demande de choisir :
   - un **nom d'utilisateur** : en minuscules, sans espace ni accent ;
   - un **mot de passe** : il n'apparaît pas quand vous le tapez, c'est normal. Retenez-le, vous en aurez besoin.
5. Ensuite, pour ouvrir votre terminal, cherchez **Ubuntu** dans le menu Démarrer.
6. Dans la fenêtre Ubuntu, installez les outils dont nous avons besoin :

   ```bash
   sudo apt update && sudo apt install -y git curl
   ```

> [!IMPORTANT]
> Sous Windows, **travaillez toujours dans la fenêtre Ubuntu**, jamais dans PowerShell ni dans l'invite de commandes classique : les commandes du cours n'y fonctionnent pas. Restez aussi dans votre dossier personnel Ubuntu (là où vous arrivez au démarrage), et évitez les dossiers qui commencent par `/mnt/c`.

En cas de problème à l'installation, la première chose à vérifier est que la virtualisation est activée sur votre ordinateur (option du BIOS/UEFI). Si vous êtes bloqué·e, prévenez l'enseignant avant la séance.

## 3. Récupérer les fichiers du cours

Dans votre terminal (Terminal sur Mac et Linux, Ubuntu sous Windows), recopiez ces commandes **une par une**, en validant avec `Entrée` :

```bash
cd ~
git clone https://github.com/VOTRE-COMPTE/cours-ligne-de-commande.git
cd cours-ligne-de-commande/corpus
bash telecharger.sh
```

Vous n'avez pas encore besoin de tout comprendre : nous reviendrons sur ces commandes pendant la séance. À la fin, le terminal doit afficher « Terminé » et la liste de trois fichiers : `candide.txt`, `germinal.txt` et `madame-bovary.txt`.

Remontez ensuite d'un dossier :

```bash
cd ..
```

## 4. Vérification

Tapez :

```bash
pwd
```

Le terminal doit afficher quelque chose qui se termine par `cours-ligne-de-commande`. Si c'est le cas, vous êtes prêt·e.

Si un message d'erreur apparaît, ne paniquez pas : **copiez-le en entier**, et demandez à Claude ce qu'il signifie. C'est justement l'exercice de la troisième partie.

---

Suite : [01 - Naviguer et ranger](01-naviguer.md)
