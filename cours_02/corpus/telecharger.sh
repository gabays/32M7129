#!/bin/bash
# Télécharge les textes du corpus depuis le Projet Gutenberg (domaine public).
# Usage : depuis le dossier corpus/, tapez   bash telecharger.sh

telecharger() {
    nom="$1"
    numero="$2"
    brut="$nom.brut"

    echo "Téléchargement de $nom.txt ..."
    if ! curl -fsSL "https://www.gutenberg.org/ebooks/$numero.txt.utf-8" -o "$brut"; then
        echo "  Échec : vérifiez votre connexion Internet."
        rm -f "$brut"
        return
    fi

    # Si le fichier n'est pas en UTF-8, on le convertit depuis ISO-8859-1
    if ! iconv -f UTF-8 -t UTF-8 "$brut" > /dev/null 2>&1; then
        iconv -f ISO-8859-1 -t UTF-8 "$brut" > "$brut.utf8" && mv "$brut.utf8" "$brut"
    fi

    # On retire les fins de ligne Windows (\r)
    tr -d '\r' < "$brut" > "$brut.lf" && mv "$brut.lf" "$brut"

    # On retire l'en-tête et le pied de page du Projet Gutenberg
    if grep -q '\*\*\* START OF' "$brut"; then
        sed -e '1,/\*\*\* START OF/d' -e '/\*\*\* END OF/,$d' "$brut" > "$nom.txt"
        rm "$brut"
    else
        mv "$brut" "$nom.txt"
    fi
}

telecharger candide 4650
telecharger madame-bovary 14155
telecharger germinal 5711

echo
echo "Terminé. Contenu du dossier :"
ls -l *.txt
