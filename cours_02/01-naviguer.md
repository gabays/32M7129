# 01 - Naviguer et ranger

> Durée : 20 minutes. Commandes vues : `pwd`, `ls`, `cd`, `mkdir`, `touch`, `cp`, `mv`, `rm`, `echo`.

## Le terminal en deux mots

Le terminal est une fenêtre où l'on **écrit des ordres** à l'ordinateur au lieu de cliquer sur des icônes. Vous tapez une commande, vous validez avec `Entrée`, l'ordinateur répond.

La ligne qui précède votre curseur s'appelle l'**invite** (le *prompt*). Elle ressemble à ceci :

```text
prenom@ordinateur:~/cours-ligne-de-commande$
```

Elle indique qui vous êtes, sur quelle machine, et **dans quel dossier vous vous trouvez** (ici `~/cours-ligne-de-commande`). Le signe `~` est un raccourci pour votre dossier personnel.

Vos fichiers sont rangés en **arborescence** : des dossiers qui contiennent des dossiers, qui contiennent des fichiers. Dans le terminal, on est toujours « placé » dans un dossier : le **dossier courant**. Se déplacer, c'est changer de dossier courant.

## Quatre réflexes à prendre tout de suite

| Geste | Effet |
|---|---|
| `Tab` | Complète automatiquement un nom de fichier ou de dossier. Tapez le début, puis `Tab`. |
| `↑` (flèche haut) | Rappelle la commande précédente. |
| `Ctrl` + `C` | Interrompt une commande qui tourne ou qui se bloque. |
| `clear` | Efface l'écran. |

Pour **coller** du texte dans le terminal : `Cmd` + `V` sur Mac, `Ctrl` + `Maj` + `V` sur Linux et sous Ubuntu (WSL).

> [!TIP]
> Dans le terminal, un espace sépare les mots d'une commande. Pour cette raison, **évitez les espaces et les accents dans vos noms de fichiers** : préférez `notes-flaubert.txt` à `Notes Flaubert.txt`.

## Les commandes

### `pwd` : où suis-je ?

```bash
pwd
```

Affiche le chemin complet du dossier courant (*print working directory*).

### `ls` : que contient ce dossier ?

```bash
ls
ls -l
ls -a
ls -la
```

- `ls` liste les fichiers et dossiers ;
- `ls -l` affiche des détails (taille, date) ;
- `ls -a` montre aussi les fichiers **cachés**, dont le nom commence par un point ;
- `ls -la` combine les deux.

Les mots précédés d'un tiret (`-l`, `-a`) s'appellent des **options** : elles modifient le comportement de la commande.

### `cd` : changer de dossier

```bash
cd corpus        # entrer dans le dossier « corpus »
cd ..            # remonter d'un niveau
cd ~             # retourner dans votre dossier personnel
cd -             # revenir au dossier précédent
```

Le point `.` désigne le dossier courant, et `..` le dossier parent. On peut aussi donner un chemin complet, par exemple `cd ~/cours-ligne-de-commande/tresor`.

**Astuce :** après chaque `cd`, faites `pwd` ou `ls` pour vérifier où vous êtes.

### `mkdir` : créer un dossier

```bash
mkdir atelier
mkdir -p atelier/auteurs/xixe     # crée aussi les dossiers intermédiaires
```

### `touch` : créer un fichier vide

```bash
touch notes.txt
```

### `echo` : afficher un texte, ou l'écrire dans un fichier

```bash
echo "Bonjour"
echo "Bonjour" > salut.txt
```

Le signe `>` envoie le résultat **dans un fichier** au lieu de l'afficher à l'écran. Attention : si le fichier existe déjà, il est écrasé. Nous y reviendrons dans la partie suivante.

### `cp` : copier

```bash
cp salut.txt copie.txt            # copie un fichier
cp salut.txt atelier/             # copie dans un dossier
cp -r atelier atelier-sauvegarde  # copie un dossier entier (-r = récursif)
```

### `mv` : déplacer ou renommer

```bash
mv copie.txt atelier/             # déplace
mv salut.txt bonjour.txt          # renomme
```

### `rm` : supprimer

```bash
rm copie.txt
rm -r atelier-sauvegarde          # supprime un dossier et son contenu
```

> [!WARNING]
> Il n'y a **pas de corbeille** dans le terminal : un fichier supprimé avec `rm` est perdu. Relisez toujours la commande avant de valider, et soyez très prudent·e avec `rm -r`.

### Obtenir de l'aide

Sous Linux et Ubuntu (WSL) : `ls --help`. Sur Mac : `man ls` (on quitte avec la touche `q`). Ou alors, vous demandez à Claude, ce que vous ferez dans la partie 03.

---

## Exercices

### Exercice 1.1 - Où suis-je ?

1. Affichez le chemin de votre dossier courant.
2. Listez son contenu, d'abord simplement, puis avec des détails.
3. Entrez dans le dossier `corpus`, listez son contenu, puis revenez dans le dossier `cours-ligne-de-commande`.

<details>
<summary>Indice</summary>

Trois commandes suffisent : `pwd`, `ls` (avec l'option `-l`) et `cd`. Pour revenir en arrière, `cd ..`.

</details>

### Exercice 1.2 - Aménager son atelier

Depuis le dossier `cours-ligne-de-commande` :

1. Créez un dossier `atelier` contenant deux dossiers : `auteurs` et `notes`.
2. Dans `notes`, créez un fichier vide `idees.txt`.
3. Écrivez dedans la phrase « Voltaire, Flaubert, Zola » avec `echo` et `>`.
4. Copiez ce fichier dans le dossier `auteurs`, sous le nom `liste.txt`.
5. Renommez `liste.txt` en `xviiie-xixe.txt`.
6. Supprimez le dossier `notes` et son contenu.
7. Vérifiez le résultat avec `ls -R atelier` : vous devez voir `auteurs` et son fichier, et plus de dossier `notes`.

<details>
<summary>Indice</summary>

Pensez à `mkdir -p` pour créer un dossier dans un dossier qui n'existe pas encore. Pour écrire dans un fichier depuis un autre dossier, on peut donner son chemin : `echo "..." > atelier/notes/idees.txt`.

</details>

### Exercice 1.3 - La chasse au trésor

Le dossier `tresor` est une petite bibliothèque. Quelque part dans ses sous-dossiers se cache **un fichier caché** qui contient le mot magique.

1. Entrez dans `tresor` et lisez les indices (nous verrons `cat` dans la partie suivante : pour l'instant, `cat nom-du-fichier` affiche le contenu d'un fichier).
2. Explorez les dossiers un par un, avec `ls` et `cd`.
3. Retrouvez le fichier caché, lisez-le et **notez le mot magique**.

<details>
<summary>Indice</summary>

Un fichier dont le nom commence par un point n'apparaît pas avec un simple `ls`. Quelle option permet de le voir ?

</details>

---

Suite : [02 - Lire et fouiller un texte](02-texte.md)
