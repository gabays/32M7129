#!/bin/bash
# Comparer plusieurs configurations de SuperStyl sur le corpus romans_20s.
#
# À lancer depuis le dossier cours_10, environnement activé :
#     bash benchmark.sh
#
# Les jeux de données déjà extraits ne sont pas recalculés : on peut relancer
# le script sans tout refaire. Le tableau final est dans benchmark/resultats.tsv

CORPUS="corpus/romans_20s/txt/*.txt"
DOSSIER="benchmark"
RESULTATS="$DOSSIER/resultats.tsv"

mkdir -p "$DOSSIER"
echo -e "donnees\toptions\taccuracy\tmacro_f1" > "$RESULTATS"

# extraire <nom> <options de load_corpus.py>
extraire () {
  nom=$1
  shift
  if [ ! -f "$DOSSIER/$nom.csv" ]; then
    echo "Extraction de $nom ($*)"
    python SuperStyl/load_corpus.py -s $CORPUS "$@" -o "$DOSSIER/$nom" > /dev/null 2>&1
  fi
}

# entrainer <nom> <options de train_svm.py>
entrainer () {
  nom=$1
  shift
  echo "Entraînement sur $nom $*"
  python SuperStyl/train_svm.py "$DOSSIER/$nom.csv" --cross_validate group-k-fold "$@" \
    -o "$DOSSIER/$nom" > "$DOSSIER/log.txt" 2>&1
  acc=$(grep "accuracy" "$DOSSIER/log.txt" | awk '{print $2}')
  f1=$(grep "macro avg" "$DOSSIER/log.txt" | awk '{print $5}')
  echo -e "$nom\t$*\t$acc\t$f1" >> "$RESULTATS"
}

# 1. Quel type de traits ? (échantillons de 2000 mots)
extraire chars3_2000   -t chars   -n 3 -k 1000 --sampling --sample_size 2000
extraire affixes_2000  -t affixes -n 3 -k 1000 --sampling --sample_size 2000
extraire mots100_2000  -t words   -n 1 -k 100  --sampling --sample_size 2000
extraire mots300_2000  -t words   -n 1 -k 300  --sampling --sample_size 2000

entrainer chars3_2000
entrainer affixes_2000
entrainer mots100_2000
entrainer mots300_2000

# 2. Quelle taille d'échantillon ? (trigrammes de caractères)
extraire chars3_500    -t chars -n 3 -k 1000 --sampling --sample_size 500
extraire chars3_1000   -t chars -n 3 -k 1000 --sampling --sample_size 1000
extraire chars3_5000   -t chars -n 3 -k 1000 --sampling --sample_size 5000

entrainer chars3_500
entrainer chars3_1000
entrainer chars3_5000

# 3. Quelles options d'entraînement ? (trigrammes, 2000 mots)
entrainer chars3_2000 --class_weights
entrainer chars3_2000 --balance downsampling
entrainer chars3_2000 --dim_reduc pca
entrainer chars3_2000 --kernel rbf

echo
echo "Résultats :"
column -t -s $'\t' "$RESULTATS" 2>/dev/null || cat "$RESULTATS"
