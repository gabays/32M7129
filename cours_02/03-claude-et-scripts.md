# 03 - Claude et premiers scripts

> Durée : 30 minutes. Notions vues : bien formuler une demande, lire une commande, écrire et lancer un script bash.

Jusqu'ici, vous avez tapé des commandes que nous vous avons données. Dans la vie réelle, on ne connaît jamais toutes les commandes par cœur : on cherche, on demande, on adapte. C'est là que Claude peut vous aider, **à condition de garder la main**.

## Claude : un assistant, pas un oracle

Claude peut vous proposer une commande, vous l'expliquer, ou écrire un petit script. Mais il peut aussi se tromper, ou ne pas deviner ce que vous voulez vraiment. Votre rôle : **poser une demande claire, comprendre la réponse, vérifier le résultat**.

### Une bonne demande contient quatre ingrédients

| Ingrédient | Exemple |
|---|---|
| **Le contexte** : votre système et votre terminal | « Je suis sur Mac, dans le terminal, avec bash. » |
| **L'objectif** : ce que vous voulez obtenir | « Je veux compter combien de fois le mot "amour" apparaît dans un fichier. » |
| **Les données** : le nom du fichier, un extrait | « Le fichier s'appelle `candide.txt`, c'est du texte brut en français, avec des accents. » |
| **La consigne** : la forme de la réponse | « Explique chaque partie de la commande. Une seule ligne, sans rien installer. » |

**Une demande vague :**

> Compte les mots.

**Une bonne demande :**

> Je suis sur Ubuntu (WSL), dans le terminal. J'ai un fichier `candide.txt` (un roman en français, texte brut, avec des accents). Donne-moi une commande bash qui affiche les 10 mots les plus fréquents, un par ligne avec leur nombre. Explique chaque partie de la commande, et n'installe rien.

### Six règles de prudence

1. **Comprenez avant d'exécuter.** Si vous ne comprenez pas une partie de la commande, demandez à Claude de l'expliquer, ligne par ligne.
2. **Méfiez-vous des commandes qui détruisent ou qui installent** : `rm`, `sudo`, `>` sur un fichier important, `apt install`, `brew install`, `pip install`… Si vous n'en avez pas demandé, posez la question à Claude avant d'exécuter.
3. **Testez sur un dossier d'exercice** ou sur une copie, jamais sur vos vrais documents.
4. **Vérifiez le résultat sur un cas que vous connaissez.** Par exemple, comparez un nombre avec celui de `wc` ou de `grep -c`.
5. **En cas d'erreur, copiez le message en entier** et collez-le dans Claude, avec la commande que vous avez tapée.
6. **Ne partagez pas de données personnelles ou confidentielles.**

### Erreurs fréquentes

| Message | Ce que cela veut dire |
|---|---|
| `command not found` | Le terminal ne connaît pas cette commande : faute de frappe, ou commande non installée. |
| `No such file or directory` | Le fichier ou le dossier n'existe pas **à cet endroit**. Vérifiez avec `pwd` et `ls`. |
| `Permission denied` | Vous n'avez pas le droit d'exécuter ce fichier. Pour un script : `chmod +x nom-du-script.sh`. |

---

## Premiers scripts

Un **script** est un fichier texte qui contient des commandes, lancées les unes après les autres. Au lieu de retaper la même commande, vous l'enregistrez une fois et vous la relancez quand vous voulez.

### Préparer un dossier

```bash
cd ~/cours-ligne-de-commande
mkdir scripts
cd scripts
```

### Écrire un script avec `nano`

`nano` est un petit éditeur de texte qui fonctionne dans le terminal. Ouvrez un nouveau fichier :

```bash
nano bonjour.sh
```

Écrivez (ou collez) ceci :

```bash
#!/bin/bash
# bonjour.sh : dit bonjour
echo "Bonjour $1 !"
```

Pour enregistrer et quitter : `Ctrl` + `O`, puis `Entrée` (pour confirmer le nom), puis `Ctrl` + `X`.

Ce que contient ce script :

- `#!/bin/bash` : la première ligne indique que le fichier est un script bash ;
- `# ...` : une ligne qui commence par `#` est un **commentaire**, ignoré par l'ordinateur, écrit pour les humains ;
- `$1` : le **premier argument**, c'est-à-dire le premier mot tapé après le nom du script.

### Lancer un script

Il faut d'abord rendre le fichier exécutable, une seule fois :

```bash
chmod +x bonjour.sh
```

Puis, pour le lancer :

```bash
./bonjour.sh Emma
```

Le `./` signifie « le fichier `bonjour.sh` situé dans le dossier courant ».

### Un script utile : compter un mot

```bash
nano compte-mot.sh
```

```bash
#!/bin/bash
# compte-mot.sh : compte les occurrences d'un mot dans un fichier
# Usage : ./compte-mot.sh mot fichier.txt
mot="$1"
fichier="$2"
grep -io "$mot" "$fichier" | wc -l
```

Ici, `mot` et `fichier` sont des **variables** : des étiquettes qui contiennent une valeur. On les utilise avec un `$` devant. Les guillemets autour de `$mot` et `$fichier` protègent les noms qui contiendraient des espaces.

```bash
chmod +x compte-mot.sh
./compte-mot.sh amour ../corpus/candide.txt
```

### Répéter une action : la boucle `for`

Une boucle répète des commandes pour chaque élément d'une liste. Exemple :

```bash
for fichier in ../corpus/*.txt; do
    echo "Je traite $fichier"
done
```

Ici, la variable `fichier` prend successivement le nom de chaque texte du corpus, et la commande entre `do` et `done` est exécutée à chaque tour.

---

## Exercices

Pour ces exercices, **Claude est votre outil** : ouvrez-le dans un onglet à côté du terminal.

### Exercice 3.1 - Lire une commande

1. Copiez cette commande dans Claude et demandez-lui de l'expliquer, morceau par morceau :

   ```bash
   grep -oE "[[:alpha:]]{4,}" candide.txt | sort -f | uniq -ic | sort -rn | head -n 10
   ```

2. Demandez à Claude ce qui se passerait si on **retirait** `sort -f`. Puis testez vous-même dans le terminal (depuis le dossier `corpus`) : sa réponse était-elle juste ?

### Exercice 3.2 - Vague, puis précis

1. Choisissez une question sur l'un des textes (par exemple : « quels sont les mots de 8 lettres ou plus les plus fréquents dans *Germinal* ? »).
2. Posez d'abord à Claude une demande **volontairement vague**. Regardez la réponse.
3. Reformulez avec les quatre ingrédients (contexte, objectif, données, consigne). Comparez.
4. Testez la commande obtenue dans le terminal. Le résultat vous paraît-il plausible ?

### Exercice 3.3 - Un script `rapport.sh`

Vous allez obtenir, avec l'aide de Claude, un script qui présente un fichier texte.

**Cahier des charges** : le script reçoit un fichier en argument (`./rapport.sh ../corpus/candide.txt`) et affiche :

- le nom du fichier ;
- son nombre de lignes ;
- son nombre de mots ;
- ses 10 mots de 4 lettres ou plus les plus fréquents.

**Étapes :**

1. Rédigez votre demande à Claude en suivant les quatre ingrédients. Copiez le cahier des charges dedans.
2. Lisez la réponse. Demandez des explications sur tout ce que vous ne comprenez pas.
3. Créez le fichier avec `nano rapport.sh`, collez le script, enregistrez.
4. Rendez-le exécutable (`chmod +x`) et testez-le sur `candide.txt`.
5. **Vérifiez** : le nombre de lignes et de mots est-il le même qu'avec `wc` ?
6. Si le script affiche une erreur, copiez le message en entier dans Claude et demandez de corriger.

<details>
<summary>Indice</summary>

Dites à Claude que le script doit fonctionner avec des fichiers en français contenant des accents, et demandez-lui de ne pas utiliser d'outil qu'il faudrait installer.

</details>

### Exercice 3.4 - Un mot, trois romans

Avec Claude, écrivez un script `compte-corpus.sh` qui reçoit **un mot** en argument et affiche, pour chacun des textes du dossier `corpus`, le nom du fichier et le nombre d'occurrences de ce mot :

```text
../corpus/candide.txt : 12
../corpus/germinal.txt : 87
../corpus/madame-bovary.txt : 41
```

*(Les nombres ci-dessus sont fictifs.)*

Indice pour votre demande : parlez à Claude de la boucle `for`.

Essayez avec plusieurs mots (« amour », « argent », « Dieu », « travail »…). Que constatez-vous ?

### Bonus - Comparer ce qui est comparable

*Germinal* est beaucoup plus long que *Candide* : comparer des nombres bruts pose problème. Demandez à Claude d'ajouter au script précédent une colonne qui donne la **fréquence pour 10 000 mots**. Pourquoi cette mesure est-elle plus juste ?

---

Suite : [04 - Bilan](04-bilan.md)
