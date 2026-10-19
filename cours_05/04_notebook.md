# LADAS2TEI 4 : installer et lancer le carnet Jupyter

**Objectif** : exécuter la partie 03 dans un **carnet Jupyter** (`03_conversion.ipynb`) : des cellules de texte et de code, avec les résultats affichés juste en dessous.

## 1. Pourquoi un carnet ?

Dans le terminal, chaque commande est tapée puis oubliée. Dans un carnet, on garde ensemble les explications, les commandes et leurs résultats, et on peut rejouer une cellule autant de fois qu'on veut. Les lignes qui commencent par `!` sont envoyées au terminal : ce sont les mêmes commandes qu'aux parties précédentes.

## 2. Installer Jupyter

Il s'installe avec `pip`, **dans le même environnement virtuel** que LADAS2TEI :

```bash
cd ~/LADAS2TEI
source venv/bin/activate
pip install jupyterlab ipykernel
```

Vérification :

```bash
which jupyter
jupyter --version
```

`which jupyter` doit pointer vers `venv/bin/jupyter`. Sinon l'environnement n'est pas activé.

## 3. Déclarer l'environnement comme « noyau »

Le **noyau** est le Python qui exécute les cellules du carnet. On enregistre celui de l'environnement virtuel pour être sûr de ne pas utiliser un autre Python :

```bash
python -m ipykernel install --user --name ladas2tei --display-name "Python (LADAS2TEI)"
```

## 4. Lancer Jupyter

Toujours depuis le dossier `LADAS2TEI`, environnement activé :

```bash
jupyter lab
```

Le navigateur s'ouvre sur l'interface Jupyter. Le terminal, lui, **ne rend plus la main** : c'est normal, il fait tourner le serveur. Laissez-le ouvert, et ouvrez un **second terminal** si vous avez besoin de taper d'autres commandes (sans oublier d'y réactiver l'environnement).

- **WSL** : si le navigateur ne s'ouvre pas, copiez dans votre navigateur Windows l'adresse affichée dans le terminal, qui ressemble à `http://localhost:8888/lab?token=...`.
- Pour arrêter Jupyter : `Ctrl + C` dans le terminal, puis confirmez avec `y`.

Variante plus simple (interface « classique ») : `pip install notebook`, puis `jupyter notebook`.

## 5. Ouvrir le carnet

Copiez le carnet dans le dossier du projet (dans un second terminal) :

```bash
cd ~/LADAS2TEI
cp <chemin>/03_conversion.ipynb .
```

Dans l'explorateur de fichiers à gauche de Jupyter, double-cliquez sur `03_conversion.ipynb`. Vérifiez en haut à droite que le noyau est bien **Python (LADAS2TEI)** ; sinon, cliquez dessus et choisissez-le.

## 6. Exécuter

- `Maj + Entrée` : exécute la cellule sélectionnée et passe à la suivante ;
- une cellule de texte (markdown) s'« exécute » aussi : elle s'affiche mise en forme ;
- menu **Kernel → Restart Kernel** : repartir de zéro si quelque chose se bloque ;
- **sauvegardez** avec `Ctrl + S` (`Cmd + S` sur Mac).

Exécutez les cellules **dans l'ordre**, de haut en bas : la première (`%cd`) place le carnet dans le bon dossier.

## Pièges classiques

| Symptôme | Cause probable |
|---|---|
| `jupyter: command not found` | environnement non activé, ou `pip install` fait hors du venv |
| `No module named lxml` dans le carnet | mauvais noyau : choisir « Python (LADAS2TEI) » |
| le navigateur ne s'ouvre pas | normal sous WSL : copier l'adresse du terminal |
| le terminal semble bloqué | normal : le serveur tourne, ouvrir un second terminal |
| `Port 8888 is already in use` | un autre Jupyter tourne : `jupyter lab --port 8889` |
| `No module named ladas2tei` | la cellule `%cd` n'a pas été exécutée |

## Exercice

1. Installer Jupyter et déclarer le noyau.
2. Lancer `jupyter lab` et ouvrir `03_conversion.ipynb`.
3. Exécuter le carnet cellule par cellule, jusqu'à la vérification du TEI.
4. Ajouter à la fin du carnet une cellule de code qui affiche la taille du fichier produit.
