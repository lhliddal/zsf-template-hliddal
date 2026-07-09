# Style Modules

Modulares Style-System, geladen von `preamble.tex` in dieser Reihenfolge:

| Modul | Inhalt |
| --- | --- |
| `00_packages.tex` | Pakete und Paket-Setup (carlito, sansmath, mathtools, siunitx, xcolor[table], tabularx, tabularray, tcolorbox, hyperref, ...) |
| `10_math.tex` | Math-Macros: `\R \C \N \Z \Q`, `\dd`, `\norm \abs`, `\sgn \grad \divg \rot`, `\vect`, ZSFsumMode/ZSFlimMode |
| `11_math_advanced.tex` | **OPT-IN** (LinAlg/Analysis): Operatoren (`\Ker \rang \Spur \diag \spanop \eig \proj` ...), aufrechtes `\Im`/`\Re`, TikZ-Klammern (`\drawbrace`/`\tikzmark`), Pfeil-Fix |
| `20_tables.tex` | Semantisches Table-System: Spaltentypen `L/C/R/Y/Z/Q/F`, `ZSFtable*`, `\ZSFheaderRow`, `\ZSFhead`, Zebra |
| `30_layout_spacing.tex` | Spacing-Skala XS/S/M/L, Schwellwerte, `\textVorBox`/`\textNachBox`/`\textVorFormel`/`\textNachFormel`, `\ZSFRobustUnskip`, Gap-Helfer |
| `40_colors_structure.tex` | 18-Slot-Index-Palette, semantische Farben, aktive Kapitelfarben, Flag-System, `\StartChapter`/`\StartFrontChapter`/`\StartChapterOnNewColumn` |
| `50_typography_semantics.tex` | Schriftmakros (`\ZSFfontChapter` etc.), `\ZSFkeyword`, `\ZSFconclusion`, Tabellen-Rules |
| `55_readability.tex` | Flattersatz + TeX-Penalties für schmale Spalten (`\ZSFReadableOn`, `ZSFReadable` env, `\ZSFbreak`/`\ZSFnobreak`) |
| `60_boxes.tex` | tcolorbox-Stile, `chapterbar`/`subsectionbar`/`subsubsectionbar` (+ `\SubsectionBarOnNewColumn`, `\SubsubsectionBarOnNewColumn`), `defbox`/`tablebox`/`figbox`/`warnbox`, `formulabox` + `\formulasep`/`\formulanote`, `runintext`, `\ZSFfig`/`\ZSFfigside`, `splitbox`, `statementbox`/`procedure`/`factlist`/`propertylist`, `valuegrid`, Goal-System (`\GoalCondition`/`\GoalTarget`/`\ZSFDerivationCase`), `\ZSFdanger` |
| `65_code_style.tex` | **OPT-IN** (Informatik): lstlisting-Style `CodeExpert`, `codebox[Titel]`, `codeboxfirst/mid/last` |
| `66_index.tex` | **OPT-IN**: Stichwortverzeichnis — `\ZSFkeyword`-Auto-Indexierung, `\ZSFindex`/`\ZSFindexsee`, `\printindex`; makeindex-Style `zsfindex.ist` |
| `67_code_comments.tex` | **OPT-IN** (Informatik, nach 65): Smart Code-Kommentare `\CodeLine{code}[comment]`, `\InlineComment`/`\OverlineComment` |
| `70_document_settings.tex` | hyperref, Math-Display-Skips, `\setlist`, Tabellen-Zellabstand, Page-Number-Overlay |
| `75_pdf_identity.tex` | PDF-Metadata (`\ZSFOwnerNameASCII`, `\ZSFSubjectTitle`, `\ZSFReleaseID`, `\ZSFBuildID`), pdfinfo + hyperref + XMP |

Kapitel bleiben inhaltsfokussiert; Layout/Styling läuft komplett über diese Module.

## Readability-System (55_readability.tex)

Fliesstext (`runintext`, `defbox`, `warnbox`) ist im **Flattersatz**, damit
LaTeX in den schmalen 4-Spalten-Zeilen lieber frueh umbricht als zu trennen
oder Leerraum aufzublaehen.

Globaler Schalter:
```latex
\ZSFReadableBodyOff  % zurück zu Blocksatz
\ZSFReadableBodyOn   % wieder an (Standard)
```

Lokal:
```latex
\begin{ZSFReadable}
  ... Text im Flattersatz ...
\end{ZSFReadable}
```

Punktuelle Steuerung:
- `\ZSFbreak` — weicher bevorzugter Umbruch
- `\ZSFnobreak` — gebundenes Leerzeichen (`5\ZSFnobreak kg`)
- `\ZSFallowbreak` — erlaubt Umbruch an sonst fester Stelle
