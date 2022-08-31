#!/bin/sh

OUTFILE=pdf/l3.pdf
COMPOSITE=composite.md
SETTINGS=pdf/settings.yaml
PANDOC=`which pandoc`

#JULIA=`which julia`
#echo $PANDOC plus $JULIA
#$JULIA composite.jl $SETTINGS $COMPOSITE

$PANDOC $COMPOSITE --from markdown --template eisvogel --pdf-engine=tectonic -V paper:letter -V 'sansfont:Brill' -V 'mainfont:Brill'  --table-of-contents --number-sections  --top-level-division=chapter -V classoption=oneside -o $OUTFILE