# Git 0 : préparation

À faire **avant** la séance. Compter 15 minutes.

## 1. Créer un compte GitHub

> **Un compte GitHub est indispensable** pour la séance : sans lui, on peut seulement *lire* et télécharger des projets publics, mais pas en créer, y pousser des modifications ni ouvrir de pull request. La création est gratuite.

1. Allez sur [github.com](https://github.com) et cliquez sur **Sign up**.
2. Choisissez un **nom d'utilisateur** : il apparaîtra dans vos adresses (`github.com/<votre-nom>`) et sur vos contributions. Préférez un nom sobre et durable.
3. Confirmez votre adresse e-mail.

> Avec une adresse universitaire, vous pouvez demander les avantages pour étudiants : [education.github.com](https://education.github.com/).

Vous pouvez aussi utiliser **GitLab**, voir la [partie 04](04-bilan.md). Les notions sont les mêmes.

> **L'Université de Genève héberge sa propre instance GitLab** : [https://gitlab.unige.ch/](https://gitlab.unige.ch/). Ce service permet :
>
> - de **savoir où sont stockées les données** ;
> - de **ne pas dépendre d'une grande entreprise** : GitHub appartient à Microsoft ;
> - de répondre à des enjeux de **souveraineté** numérique, d'autant plus importants depuis que des systèmes d'IA collectent le contenu des dépôts publics pour s'entraîner.
>
> On y place de préférence les données de recherche sensibles ou les travaux que l'on ne veut pas exposer. Pour ce cours, nous utilisons quand même GitHub, car c'est là que se trouve l'essentiel des projets ouverts, dont ceux des séances précédentes. Les notions sont les mêmes sur les deux plateformes.

## 2. Installer GitHub Desktop

Téléchargez l'application sur [desktop.github.com](https://desktop.github.com) (macOS et Windows) et installez-la.

> **Linux** : GitHub Desktop n'existe pas officiellement. Utilisez la ligne de commande (parties « Dans le terminal »), ou une version communautaire.

Au premier lancement, **Sign in to GitHub.com** : une page web s'ouvre, connectez-vous et autorisez l'application. Aucun mot de passe n'est tapé dans l'application.

## 3. Vérifier que git est installé

GitHub Desktop embarque son propre git, mais la ligne de commande a besoin du sien :

```bash
git --version
```

- **macOS** : la première utilisation propose d'installer les outils de ligne de commande d'Apple. Acceptez.
- **Windows** : installez [Git for Windows](https://git-scm.com/download/win), ou utilisez WSL (`sudo apt install -y git`).

## 4. Dire qui vous êtes

Chaque version enregistrée porte un nom et une adresse. 

- **Dans GitHub Desktop** : `File > Options > Git` (Windows) ou `GitHub Desktop > Settings > Git` (macOS), puis remplissez *Name* et *Email*.
- **Dans le terminal** :

```bash
git config --global user.name "Prénom Nom"
git config --global user.email "vous@exemple.org"
git config --global init.defaultBranch main
git config --global --list
```

> L'adresse que vous mettez ici sera **visible publiquement** dans l'historique des projets publics. GitHub propose une adresse anonyme du type `123456+nom@users.noreply.github.com` (`Settings > Emails`) : utilisez-la si vous préférez ne pas exposer la vôtre.

## Vérification

Avant la séance, vous devez avoir : un compte GitHub, GitHub Desktop connecté à ce compte, `git --version` qui répond, et vos nom et adresse configurés.
