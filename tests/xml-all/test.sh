#!/bin/bash

# Variablen
EXECPATH=/path/to/this/collection
CONTEXTSOURCE=/path/to/context/installation/2016-12/tex/setuptex
XMLPATH=/path/to/this/collection/xml
options=$@

#change directory
cd $EXECPATH

# ConTeXt root setzen
source $CONTEXTSOURCE

# die Tex Datei erstellen
read -d '' -r texstring << EOF
\startproduct prd_document
\project project_ediarum_context
\environment env_TEI2tex

\doifmode{referenzen}{\component c_Referenzen}

\FSBstartreferenzen{}
\starttext
EOF

echo "$texstring" > $EXECPATH/tmp.tex

for file in $XMLPATH/*.xml; do
	if [[ $(echo $file | grep '\\') ]]; then
		echo "Invalid Filename: $file"
	else
		echo -e "\t\\xmlprocessfile{tei}{$file}{}" >> $EXECPATH/tmp.tex
	fi
done

read -d '' -r texstring << EOF
\stoptext
\FSBstopreferenzen{}

\doifmode{register}{\component c_Register}
\stopproduct
EOF

echo "$texstring" >> $EXECPATH/tmp.tex

if [ "${options}" = "referenzen" ]; then
# 2-maliger Durchlauf
	context --batchmode --noconsole --mode=referenzen $EXECPATH/tmp.tex
	[ $? = 0 ] || {
		echo "Content-type: text/plain"
		echo
		echo "Fehler bei der Erstellung des PDFs!"
		# echo ""
		# echo "Fehler wurde vermutlich vom folgenden Brief verursacht:"
		# pdftotext $EXECPATH/tmp.pdf - | grep -C 50 '^188$' | grep 'prov'
		exit 1
	}
	context --batchmode --noconsole --mode=referenzen $EXECPATH/tmp.tex
	[ $? = 0 ] || {
		echo "Content-type: text/plain"
		echo
		echo "Fehler bei der Erstellung des PDFs!"
		# echo ""
		# echo "Fehler wurde vermutlich vom folgenden Brief verursacht:"
		# pdftotext $EXECPATH/tmp.pdf - | grep -C 50 '^188$' | grep 'prov'
		exit 1
	}
elif [ "${options}" = "referenzen register" ]; then
	echo "Not implemented"
elif [ "${options}" = "register" ]; then
	echo "Not implemented"
else
	context --batchmode --noconsole $EXECPATH/tmp.tex
	[ $? = 0 ] || {
		echo "Content-type: text/plain" >&2
		echo >&2
		echo "Fehler bei der Erstellung des PDFs!" >&2
		# echo "" >&2
		# echo "Fehler wurde vermutlich vom folgenden Brief verursacht:" >&2
		# pdftotext $EXECPATH/tmp.pdf - | grep -C 50 '^188$' | grep 'prov' >&2
		exit 1
	}
fi

echo "=============================="
echo "PDF Generierung abgeschlossen!"
echo "=============================="
