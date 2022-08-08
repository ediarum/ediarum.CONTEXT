# ediarum.CONTEXT

© 2011-2022 by Berlin-Brandenburg Academy of Sciences and Humanities

Part of ediarum <https://www.ediarum.org/index.html> (ediarum@bbaw.de)

Developed by TELOTA, a DH working group of the Berlin-Brandenburg Academey of Sciences and Humanities
<https://www.bbaw.de/telota> (telota@bbaw.de)

ediarum.CONTEXT ist ein Modul, um TEI-XML mithilfe des Satzprogramms ConTeXt in ein PDF umzuwandeln.

**Das Modul wird nicht mehr weiterentwickelt, die letzte Änderung stammt aus 2017.**

Authors:

- Martin Fechner
- Daniel Althof

Contributers:

- Justin Pauckert
- Philipp Belitz

## Status der Entwicklung

Die Entwicklung an ediarum.CONTEXT wurde 2021 zugunsten von ediarum.PDF eingestellt.
Dennoch möchten wir den Code für die Nachnutzung zur Verfügung stellen.
Daher wird ediarum.CONTEXT im letzten Bearbeitungsstand, der aus dem Jahr 2017 stammt, publiziert.
Der Code wurde zuletzt mit einer Standalone ConTeXt-Version aus dem Jahr 2016 benutzt.
Für die Nachnutzung des Codes werden im folgenden Hinweise gegeben. Diese können unvollständig oder veraltet sein. Support können wir leider nicht anbieten.

## Zitierinweis

Wenn Sie diese Software nutzen, benutzen Sie bitte die Metadaten aus der Datei CITATION.CFF (mehr Informationen zum Dateiformat CFF gibt es unter <https://citation-file-format.github.io/>).

## Über ConTeXt

Informationen zu ConTeXt gibt es unter <http://contextgarden.net>. Die Mailingliste ist unter *ntg-context@ntg.nl* zu erreichen bzw. kann man sich unter <http://www.ntg.nl/mailman/listinfo/ntg-context> anmelden. ConTeXt wird von der Firma *Pragma Ade* unter Leitung von *Hans Hagen* entwickelt, die Webseite findet sich unter <http://www.pragma-ade.nl> bzw. <http://tex.aanhet.net>.

### Installation und Update

In der TeX-Live Distribution ist ConTeXt enthalten. Allerdings in einer älteren Version. Die neueste Beta-Version kann als Standalone bezogen werden. Die notwendigen Hinweise finden sich unter <http://wiki.contextgarden.net/ConTeXt_Standalone>. Der Download geschieht mit `rsync` und benötigt einen freien Port 873. Das Update funktioniert durch wiederholten Aufruf der `first-setup.bat`. Pakete von dritten werden etwa mit `first-setup.sh --modules="t-letter"` installiert. Beim Update werden diese wieder entfernt, es sei denn man läßt `first-setup.bat --keep` laufen.

#### Installation unter Linux

Zur Installation von ConTeXt auf Linux in der Standalone Version ohne Pfadvariablen wird das aktuelle Skript von <http://minimals.contextgarden.net/setup/first-setup.sh> in das Programmverzeichnis (etwa: `context/`) gelegt. Da das Update für die Linux-64bit-Version nicht funktioniert, muß in dem Skript noch die Zeile `platform="linux"` entkommentiert werden. Mit `sh first-setup.sh –modules=all` wird das Update ausgeführt. Die Datei `context/tex/setuptex` muß entsprechend mit der Zeile `platform="linux"` unter dem Test auf `"$platform"="unknown"` eingefügt werden.
Damit ConTeXt in einem Terminal ausgeführt werden kann, muß in diesem zunächst `source context/tex/setuptex` gestartet werden.

#### Installation von Schriften

Für die Installation von Schriften für ConTeXt mkiv sollte der Anleitung unter <http://wiki.contextgarden.net/Fonts_in_LuaTeX> gefolgt werden. Dabei werden die Systemschriften genutzt. Bei der Standalone-Version sollte mit `first-setup.bat --modules=all` (bzw. `modules="t-simplefonts"`) das notwendige Modul heruntergeladen werden. Mit `mtxrun --generate` wird dann ConTeXt aktualisiert. In der ConTeXtdatei muß nur noch `\usemodule[simplefonts]` eingebunden werden und mit `\setmainfont[schriftname]` kann die Schrift verwendet werden bzw. mit `\showfont[schriftname]` kann sie angezeigt werden.

Im Falle, dass die Schrift zu klein ist: Nach einem Neustart und dem nochmaligen von `texfont.pl --ve=test --co=test --en=texnansi --ma --in` wurde die Schrift in das Verzeichnis `tex/texmf-local/fonts` installiert, nach dem Durchlaufen von `context –generate` und `mtxrun --script fonts --reload` konnte die Schrift dann angezeigt werden. Wichtig ist, daß der Name der Schriftdatei ausschließlich Kleinbuchstaben enthält.

### Erstellung des PDFs

Zunächst muss mit `source context/tex/setuptex` die richtige Umgebung geladen werden. Ansonsten wird eine andere installierte ConTeXt-Version (etwa aus TeX-Live) benutzt. Das PDF kann dann aus der entsprechenden TeX-Datei mit dem Befehl `context name.tex` erstellt werden. Dabei werden ein PDF als `name.pdf`, eine Logfile als `name.log` und eine interne Datei mit den Referenzen etc. als `name.tuc` erstellt. Mit den Parametern `--batchmode` und `--noconsole` wird der größte Teil der Ausgabe auf der Konsole während der Erstellung unterdrückt.

#### Modi

Es gibt verschiedene Modi in denen man die pdf-Erstellung starten kann. Dazu führt man den Befehl `context --mode=modename name.tex` aus. Die wichtigsten Modi sind:

- `referenzen`: Für die Benutzung und Erstellung von Referenzen zwischen den Dateien.

## Verzeichnisstruktur

Das Verzeichnis für die PDF-Erstellung ist nach den Vorschlägen von ConTeXt (s. <http://wiki.contextgarden.net/Project_structure>) gegliedert. Danach besteht ein Projekt einerseits aus Umgebungsvariablen, welche für die Konfiguration des Druck zuständig sind, sowie aus einzelnen Produkten, die jeweils ein eigenes PDF darstellen. Jedes Produkt besteht wiederum aus einzelnen Komponenten, die jeweils Teile eines Druckes darstellen.

### Projekt

Im Hauptverzeichnis finden sich die verschiedenen Umgebungsdateien, welche für die richtige Konfiguration der Druckausgabe sorgen. Deren Namen beginnen mit "env". Im Hauptverzeichnis liegt außerdem auch die Projektdatei, in welcher auf die Umgebungsdateien und die einzelnen Produkte verwiesen wird. Für allgemeine Bilder die in mehreren Produkten verwendet werden gibt es den Ordner `/general_img`, außerdem gibt noch den Ordner `/general_files`, in welchem sich die produktübergreifenden Dateien befinden.

### Produkte und Komponenten

Jedes Produkt liegt jeweils in einem eigenen Subordner. Es gibt die Produkte:
`/tests` für die Kontrolle, ob alle Features die korrekte Ausgabe liefern.

In den einzelnen Produktordnern befinden sich für produktspezifische Bilder jeweils der Ordner `/produktname/img`, für die xml-Dateien der Ordner `/produktname/xml`.
Außerdem enthalten die jeweiligen Produktordner die Produktdatei (`/produktname/prd_name.tex`) und die Komponenten (`/produktname/c_name.tex`).
Bei der PDF-Erstellung werden von ConTeXt zudem neben der pdf-Datei `prd_name.pdf` noch eine Protokolldatei `prd_name.log`, und eine strukturierte Datei für ConTeXt-spezifische Daten `prd_name.tuc` angelegt.
Wenn bei der PDF-Erstellung der Modus "referenzen" benutzt wird, um die Referenzierung zwischen den Briefen und Vorlesungen zu unterstützen, werden auch die Dateien `lokaleReferenzen.xml` und `referenzen.xml` erstellt. Diese enthalten in einem xml-Format die aktuellen Referenzen der aktuellen pdf-Generierung, sowie die gesammelten Referenzen vorheriger pdf-Erstellungen.

### Die Umgebungsdateien

In den Umgebungsdateien ist die Konfiguration von ConTeXt festgehalten. Funktionsbezogen existieren dabei mehrere Dateien, diese sind:

| Name                  | Beschreibung      |
| :-------------------- | :---------------- |
| `env_definitions.tex` | Hält alle dateiübergreifenden Definitionen fest. |
| `env_setups.tex`      | Definiert alle Konfigurationen des Drucks. |
| `env_lua.tex`         | Definiert alle Funktionen mit Lua-Programmierung. |
| `env_TEI2tex.tex`     | Definiert die Transformationsregeln, die auf die xml-Dateien angewendet werden. |
| `env_referenzen.tex`  | Definiert die Transformationsregeln, um die externe Referenzdatei einzulesen. |

### Referenzdatei

Mit dem Modus `referenzen` wird aus dem aktuell laufenden Produkt heraus eine externe Datei `lokaleReferenzen.xml` erzeugt, in welcher für alle referenzierbaren xml-Elemente der aktuellen Dateien die Zeilennummern des aktuellen Drucks festgehalten werden. Diese Datei kann über die xsl-Transformation `referenzen.xsl` im Ordner `/general_files` mit den bisher schon festgehaltenen Referenzen in der Datei `referenzen.xml` kombiniert und gespeichert werden. Die Dateien `lokaleReferenzen.xml` sowie `referenzen.xml` werden über die entsprechende Komponente `c_Referenzen.tex` eingelesen und die Referenzen können dann im aktuellen Produkt verarbeitet werden.

## Offene Probleme

- Von Text umflossene Bilder inklusive Zeilennummerierung
- Aufruf von xml-Dateien durch URL
- Ein Fehler ist aufgetreten, als der Text eine bestimmte Komplexität überschritt (Länge des Textes und Zahl der Zeilenreferenzierungen) und die Fehlermeldung für nicht gefundene Referenzen in SETexportelementline zu lang war (mehr als 12 Zeichen).

## Unterstützte Elemente und Features

### Auswahl der Features

- Zeilennummerierung
- Apparate mit Referenzierung auf die Zeile
- Getrennter Sach- und Textapparat
- Kopfzeilen
- Endnoten

### TEI-Elemente (unvollständige Liste)

#### rs

- Sachregister aus Basisframework

#### table

- Für 3-, 2-, und 1-Spaltige Tabellen

#### Deckblatt

- Notebook-Titel für Deckblatt
- Selector für Herausgeber: `teiHeader/fileDesc/publicationStmt/publisher/ref`
- Selector für Kollektion: `msIdentifier/collection anstelle von msIdentifier/repository`

#### Autoren-Fußnoten

- Endnoten in Fußnoten umgewandelt
  - Unter `\startxmlsetups xml:tei:text` die Zeile `\placenotes[FSBautornote]` entfernt (damit Endnoten nicht gedruckt werden)
  - in `env_definitions.tex` `\definenote[FSBdofootnote]` eingefügt
  - in `env_definitions.tex` `\def\FSBfootnote{\SETfootnote}` eingefügt für Aufruf
  - in `env_setups.tex` `\def\Setfootnote` eingefügt für Ausführung
  - in `env_setups.tex` `\setupnote[FSBdofootnote]` und `\setupnotation[FSBdofootnote]` eingefügt für Styling

#### del

- `<del>` Element ohne Vorgänger oder Nachfolger angegeben - entsprechend Löschzeichen gesetzt, das in Apparat wiederholt wird
- TODO: Löschzeichen ändern

#### hi

- hi rendition="normal" für Langschrift
- hi rendition="uu" für doppete Unterstreichung

#### list

- Listen ohne Attribut (z.B. `@type="bulleted"`)
- Listenelemente mit Anstrich statt Punkt

#### seg

- `<seg>` für Sachkommentar bzw. Textapparat

## License

ediarum.CONTEXT is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

ediarum.CONTEXT is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with ediarum.CONTEXT  If not, see <http://www.gnu.org/licenses/>.
