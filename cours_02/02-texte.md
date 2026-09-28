# 02 - Lire et fouiller un texte

> Durée : 25 minutes. Commandes vues : `cat`, `head`, `tail`, `less`, `wc`, `grep`, `sort`, `uniq`, les pipes `|` et la redirection `>`.

Dans cette partie, vous travaillez sur le corpus : trois romans en fichiers texte, dans le dossier `corpus/`.

```bash
cd ~/32M7129/cours_02/corpus
ls -l
```

## Lire un fichier

```bash
cat candide.txt          # affiche tout le fichier (long !)
head candide.txt         # les 10 premières lignes
head -n 20 candide.txt   # les 20 premières lignes
tail -n 5 candide.txt    # les 5 dernières lignes
less candide.txt         # lecture page par page
```

Dans `less` : `Espace` pour avancer d'une page, `/mot` pour chercher un mot (puis `n` pour l'occurrence suivante), `q` pour quitter.

> [!TIP]
> Si un `cat` déclenche un défilement interminable, faites `Ctrl` + `C`.

## Mesurer : `wc`

`wc` (*word count*) compte les lignes, les mots et les caractères.

```bash
wc candide.txt          # lignes, mots, octets
wc -l candide.txt       # lignes seulement
wc -w candide.txt       # mots seulement
```

## Chercher : `grep`

`grep` affiche les lignes qui contiennent un mot ou une expression.

```bash
grep tempête candide.txt            # lignes contenant « amour »
grep -i tempête candide.txt         # sans tenir compte des majuscules
grep -in tempête candide.txt        # avec le numéro de chaque ligne
grep -ic tempête candide.txt        # combien de lignes ?
grep -i -C 1 tempête candide.txt    # avec 1 ligne de contexte avant et après
```

Vous pouvez chercher dans **plusieurs fichiers à la fois** avec un joker `*` :

```bash
grep -ic tempête *.txt
```

## Enchaîner les commandes : le pipe `|`

Le **pipe** (le trait vertical `|`) prend le résultat d'une commande et l'envoie à la suivante. C'est l'idée la plus puissante du terminal : des petits outils simples, que l'on assemble.

```bash
grep -i tempête candide.txt | wc -l
```

Ici, `grep` trouve les lignes, et `wc -l` les compte. Pour taper `|` : `Alt Gr` + `6` sur un clavier français Windows/Linux, `Alt` + `Maj` + `L` sur un clavier français Mac.

## Enregistrer un résultat : `>`

```bash
grep -i -C 1 amour candide.txt > amour-candide.txt
```

Au lieu de s'afficher à l'écran, le résultat est écrit dans le fichier `amour-candide.txt`. Avec `>>`, on **ajoute** à la fin d'un fichier sans l'écraser.

## Compter les mots : trois briques

Pour compter les mots les plus fréquents, il faut d'abord obtenir **un mot par ligne**. On utilise `grep` avec l'option `-o`, qui n'affiche que la partie qui correspond, et une expression qui décrit « une suite de lettres » :

```bash
grep -oE "[[:alpha:]]+" candide.txt | head -n 10
```

- `-o` : n'affiche que les morceaux trouvés (les mots), un par ligne ;
- `-E` : active les expressions régulières étendues ;
- `[[:alpha:]]+` : une ou plusieurs lettres, accentuées ou non.

Puis on trie et on compte :

```bash
grep -oE "[[:alpha:]]+" candide.txt | sort -f | uniq -ic | sort -rn | head -n 10
```

Chaque étape a son rôle :

| Étape | Rôle |
|---|---|
| `grep -oE "[[:alpha:]]+"` | extrait les mots, un par ligne |
| `sort -f` | trie par ordre alphabétique, sans tenir compte de la casse |
| `uniq -ic` | regroupe les lignes identiques et les **compte** (`-c`), sans tenir compte de la casse (`-i`) |
| `sort -rn` | trie les résultats par nombre (`-n`), du plus grand au plus petit (`-r`) |
| `head -n 10` | garde les 10 premiers |

Construisez cette commande **brique par brique** : lancez la première, puis ajoutez la suivante, et regardez ce que chaque étape change.

> [!NOTE]
> Si les mots accentués apparaissent coupés (par exemple « é » et « t » séparés dans « été »), c'est que votre terminal n'est pas configuré en UTF-8. Prévenez l'enseignant.

---

## Exercices

### Exercice 2.1 - Prendre la mesure

1. Combien de lignes et de mots contient chacun des trois textes ? Une seule commande suffit.
2. Quel texte est le plus long ? Le plus court ?

<details>
<summary>Indice</summary>

`wc` accepte plusieurs fichiers, et le joker `*.txt` les désigne tous.

</details>

### Exercice 2.2 - Lignes et occurrences

1. Combien de **lignes** de `madame-bovary.txt` contiennent le mot « amour » ?
2. Combien d'**occurrences** de « amour » y a-t-il ? (Attention : une ligne peut en contenir plusieurs.)
3. Pourquoi les deux nombres sont-ils différents ? Que compte-t-on avec `grep -c`, et que compte-t-on avec `grep -o | wc -l` ?

<details>
<summary>Indice</summary>

`grep -c` compte des lignes. Pour compter des occurrences, faites d'abord afficher **chaque occurrence sur sa propre ligne** (option `-o`), puis comptez les lignes avec `wc -l`.

</details>

### Exercice 2.3 - Un concordancier maison

Un concordancier montre un mot **dans son contexte**.

1. Cherchez « grève » dans `germinal.txt` avec une ligne de contexte avant et après.
2. Enregistrez le résultat dans un fichier `concordance-greve.txt`.
3. Vérifiez le fichier avec `less`.
4. Essayez avec un autre mot de votre choix, qui vous intéresse dans l'un des trois textes.

### Exercice 2.4 - Les mots les plus fréquents

1. Affichez les 10 mots les plus fréquents de `candide.txt`.
2. Que remarquez-vous ? Ces mots vous apprennent-ils quelque chose sur le texte ?
3. Refaites l'exercice en ne gardant que les mots de **4 lettres ou plus** : remplacez `[[:alpha:]]+` par `[[:alpha:]]{4,}`. Qu'est-ce qui change ?
4. Comparez avec `madame-bovary.txt` et `germinal.txt`.
5. Enregistrez dans un fichier `frequences-candide.txt` la liste des **30** mots de 4 lettres ou plus les plus fréquents de Candide.

<details>
<summary>Indice</summary>

Vous avez la commande dans ce document. Il suffit de changer le nom du fichier, l'expression entre guillemets, et le nombre après `head -n`. Pour enregistrer, ajoutez `> nom-du-fichier.txt` à la toute fin.

</details>

### Exercice 2.5 - Qu'est-ce qu'un mot ? (à discuter)

Comparez :

```bash
wc -w candide.txt
grep -oE "[[:alpha:]]+" candide.txt | wc -l
```

1. Les deux nombres sont-ils identiques ? Pourquoi ?
2. Comment `wc -w` traite-t-il « l'amour » ? Et notre commande avec `grep -o` ?
3. Que peut-on en conclure pour une étude sur les mots d'un texte ?

### Bonus - Les mots qui n'apparaissent qu'une fois

Combien de mots n'apparaissent qu'**une seule fois** dans `candide.txt` (les *hapax*) ?

<details>
<summary>Indice</summary>

Reprenez la commande de fréquence, sans `sort -rn` ni `head`. La sortie de `uniq -c` commence par le nombre d'occurrences : cherchez les lignes où ce nombre est `1` avec `grep "^ *1 "`, puis comptez-les avec `wc -l`.

</details>

---

Suite : [03 - Claude et premiers scripts](03-claude-et-scripts.md)
