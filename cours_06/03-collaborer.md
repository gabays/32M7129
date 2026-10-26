# Git 3 : branches et pull requests

**Objectif** : travailler sans risque sur une branche et proposer une modification par pull request.

## 1. Pourquoi une branche ?

La branche `main` doit rester **propre** : c'est la version qui fait foi. Pour essayer une correction, une nouvelle section ou une idée, on crée une **branche** : une ligne de travail parallèle. Si le résultat est bon, on la fusionne dans `main` ; sinon, on la jette sans dommage.

```text
main     ●────●────●─────────────●   (fusion)
                    \           /
correction           ●────●────●
```

## 2. Créer une branche et y travailler

**Avec GitHub Desktop**

1. Menu `Current Branch` (en haut) > `New Branch`.
2. Nom : `correction-strophe-2`, puis `Create Branch`.
3. Modifiez `poeme.txt`, faites un commit comme d'habitude : il est enregistré **sur la branche**.
4. Cliquez sur `Publish branch` pour l'envoyer sur GitHub.

**Dans le terminal**

```bash
git switch -c correction-strophe-2
# modifier poeme.txt
git add poeme.txt
git commit -m "Corrige la strophe 2"
git push -u origin correction-strophe-2
```

Pour revenir sur `main` et constater que votre modification n'y est pas encore : `git switch main` (ou le menu `Current Branch`).

## 3. La pull request

Le schéma suivant montre la vie d'un projet : branches, issues, fork, pull request, fusion, version publiée.

![Le cycle d'un projet sur GitHub : issues, branches, fork, pull request, merge, release](images/process.png)

*Schéma sous licence CC BY-SA ; auteurs indiqués sur l'image : JAM (bcnparticipa.cat/decidimjam) et SOM Research (som-research.uoc.edu).*

Une **pull request** (PR) demande de fusionner une branche dans `main`. Elle permet de **relire** les changements, de les commenter, puis de les accepter. Dans un projet à plusieurs, c'est le moyen normal de contribuer.

1. Dans GitHub Desktop, après avoir publié la branche : **Create Pull Request** (ou sur github.com, bandeau jaune `Compare & pull request`).
2. Donnez un titre et une description : *quoi*, et *pourquoi*.
3. Sur la page de la PR, onglet `Files changed` : les lignes ajoutées et supprimées. On peut y laisser des commentaires.
4. Si tout est bon : **Merge pull request** puis **Confirm merge**.
5. Supprimez la branche (`Delete branch`) : elle n'a plus d'utilité.
6. Revenez sur `main` dans GitHub Desktop et faites `Pull origin` : votre ordinateur récupère la fusion.

> Sur **GitLab**, la même chose s'appelle une **merge request** (MR).

## Exercice

1. Créez une branche `ajout-notes`, ajoutez un fichier `notes.md` avec trois remarques sur le poème, faites-en un commit et publiez la branche.
2. Ouvrez une pull request vers `main`, puis fusionnez-la.
3. Revenez sur `main`, faites `Pull origin` : le fichier `notes.md` doit apparaître.

Étape suivante : [04-bilan.md](04-bilan.md)
