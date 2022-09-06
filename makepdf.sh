#!/bin/sh
SOURCEDIR=pdfsource

echo "Sync files to " $SOURCEDIR
RSYNC=`which rsync`
$RSYNC -avz docs/ --exclude 2021-2022 $SOURCEDIR


echo "Create composite markdown file..."
COMPOSITE=composite.md
SETTINGS=pdf/settings.yaml
JULIA=`which julia`

echo "Create composite markdown file..."
echo $JULIA composite.jl $SOURCEDIR $SETTINGS $COMPOSITE 
$JULIA composite.jl $SOURCEDIR  $SETTINGS $COMPOSITE


echo "Format PDF with pandoc..."
OUTFILE=pdf/l3.pdf
PANDOC=`which pandoc`
$PANDOC $COMPOSITE --from markdown --template eisvogel --pdf-engine=tectonic -V paper:letter -V 'sansfont:Brill' -V 'mainfont:Brill'  --table-of-contents --number-sections  --top-level-division=chapter -V classoption=oneside -o $OUTFILE


echo ""
echo "Final PDF is in " $OUTFILE