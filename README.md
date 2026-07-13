# Hliddal Template für Zusammenfassungen

## Download

**Template-PDF:** [template_fs0000_hliddal.pdf herunterladen](https://github.com/lhliddal/zsf-template-hliddal/releases/latest/download/template_fs0000_hliddal.pdf)

Wenn du nur sehen willst, wie das Template aussieht, reicht diese PDF. Sie ist
als dreiseitige Living Showcase aufgebaut: stabile Boxen und Makros, optionale
Module, vorläufige Kompatibilitätsbausteine, alle 18 Kapitel-Farben und das
Stichwortverzeichnis werden direkt vergleichbar dargestellt. Den LaTeX-Code
brauchst du, wenn du damit eine eigene Zusammenfassung bauen willst.

## Persönlicher Hinweis

Ich habe dieses Template gebaut, weil ich meine Zusammenfassungen möglichst übersichtlich, kompakt und prüfungstauglich setzen wollte. Eine ZSF soll in der Prüfung Zeit sparen: Inhalte sollen schnell auffindbar, direkt anwendbar und sinnvoll aufgebaut sein. Struktur, Inhalt und Layout sollen darauf ausgelegt sein, dass man unter Prüfungsdruck intuitiv findet, was man sucht.

Fachspezifische Zusatzanforderungen gehören nur in die jeweilige ZSF. Was bei einem Fach sinnvoll ist, kann bei einem anderen unnötiger Ballast sein.

Beispiel: Eine Informatik-ZSF kann zusätzlich festhalten, dass Codebeispiele als übertragbare Skelette gedacht sind und Theorie-, Single-Choice- sowie Multiple-Choice-Aufgaben durch klare Begriffe, Eigenschaften und Entscheidungskriterien unterstützt werden sollen.

Wenn du es verwendest, verlinke bitte dieses Repository und kennzeichne eigene Änderungen sauber.

## Nutzung

Dieses Repository ist ein schlankes LaTeX-Template für ZSF-Zusammenfassungen. Es ist für kompakte, gut bearbeitbare Prüfungszusammenfassungen gedacht.

Nutzung, Anpassung und Weitergabe sind willkommen. Bitte die im PDF ausgewiesene Originalfassung nennen und Änderungen als "Bearbeitet von ..." kennzeichnen.

## LaTeX bearbeiten

```bash
make build
```

Die Quellen liegen in `main.tex`, `preamble.tex`, `chapters/`, `styles/` und den benötigten Grafikordnern. Der Build erzeugt `template_fs0000_hliddal.pdf` lokal im Repository-Root. Diese Build-Datei wird nicht versioniert; die oben verlinkte PDF im GitHub Release ist die veröffentlichte Fassung.
