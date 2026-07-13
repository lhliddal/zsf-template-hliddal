# Style Modules

Modulares Style-System, geladen von `preamble.tex` in dieser Reihenfolge:

| Modul | Inhalt |
| --- | --- |
| `00_packages.tex` | Immer aktive Basispakete und deren Setup (carlito, sansmath, mathtools, siunitx, xcolor[table], tabularx, tabularray, tcolorbox, hyperref, ...) |
| `10_math.tex` | Math-Macros: `\R \C \N \Z \Q`, `\dd`, `\norm \abs`, `\sgn \grad \divg \rot`, `\vect`, ZSFsumMode/ZSFlimMode |
| `11_math_advanced.tex` | **OPT-IN** (LinAlg/Analysis): Operatoren (`\Ker \rang \Spur \diag \spanop \eig \proj` ...), aufrechtes `\Im`/`\Re`, TikZ-Klammern (`\drawbrace`/`\tikzmark`), Pfeil-Fix |
| `12_plots.tex` | **OPT-IN**: lädt `pgfplots` und setzt die zentrale Kompatibilitätsversion |
| `20_tables.tex` | Semantisches Table-System: Spaltentypen `L/C/R/Y/Z/Q/F`, `ZSFtable*`, `\ZSFheaderRow`, `\ZSFhead`, Zebra |
| `30_layout_spacing.tex` | Spacing-Skala XS/S/M/L, Schwellwerte, `\textVorBox`/`\textNachBox`/`\textVorFormel`/`\textNachFormel`, `\ZSFRobustUnskip`, Gap-Helfer |
| `40_colors_structure.tex` | 18-Slot-Index-Palette, semantische Farben, aktive Kapitelfarben, Flag-System, `\StartChapter`/`\StartFrontChapter`/`\StartChapterOnNewColumn` |
| `50_typography_semantics.tex` | Schriftmakros (`\ZSFfontChapter` etc.), `\ZSFkeyword`, `\ZSFconclusion`, Tabellen-Rules |
| `55_readability.tex` | Flattersatz + TeX-Penalties für schmale Spalten (`\ZSFReadableOn`, `ZSFReadable` env, `\ZSFbreak`/`\ZSFnobreak`) |
| `60_boxes.tex` | tcolorbox-Stile, `chapterbar`/`subsectionbar`/`subsubsectionbar` (+ `\SubsectionBarOnNewColumn`, `\SubsubsectionBarOnNewColumn`), `defbox`/`tablebox`/`figbox`/`warnbox`, `formulabox` + `\formulasep`/`\formulanote`, `runintext`, `\ZSFfig`/`\ZSFfigside`, `splitbox[Anteil][Optionen]`, `statementbox`/`procedure`/`factlist`/`propertylist`, `valuegrid`, Goal-System (`\GoalCondition`/`\GoalTarget`/`\ZSFDerivationCase`), `\ZSFdanger` |
| `65_code_style.tex` | **OPT-IN** (Informatik): lädt `listings` samt tcolorbox-Library; Style `CodeExpert`, `codebox[Titel]`, `codeboxfirst/mid/last` |
| `66_index.tex` | **OPT-IN**: lädt `makeidx`; Stichwortverzeichnis mit `\ZSFkeyword`-Auto-Indexierung, `\ZSFindex`/`\ZSFindexsee`, `x.x`-/`x.x.x`-Locator und `zsfindex.ist` |
| `67_code_comments.tex` | **OPT-IN** (Informatik, nach 65): Smart Code-Kommentare `\CodeLine{code}[comment]`, `\InlineComment`/`\OverlineComment` |
| `75_pdf_identity.tex` | PDF-Metadata (`\ZSFOwnerNameASCII`, `\ZSFSubjectTitle`, `\ZSFReleaseID`, `\ZSFBuildID`), pdfinfo + hyperref + XMP |
| `70_document_settings.tex` | wird wegen der Release-ID nach `75_pdf_identity` geladen; Linkfarben, Math-Display-Skips, Listen, Tabellen-Zellabstand und Footer-Overlay |

Kapitel bleiben inhaltsfokussiert; Layout/Styling läuft komplett über diese Module.

## Living Showcase und Fach-Fork

`main.tex` setzt im Template-Repository den Marker `\ZSFShowcaseMode`. Dadurch
lädt `preamble.tex` für die Showcase gezielt alle Opt-in-Module und kann deren
echte Darstellung prüfen. `scripts/init_project.sh` entfernt den Marker zusammen
mit den Showcase-/Palette-Kapiteln. Ein initialisierter Fach-Fork startet deshalb
weiterhin mit allen optionalen Modulen deaktiviert; dort werden sie ausschliesslich
über die kommentierten `\input`-Zeilen in `preamble.tex` gewählt.

## Öffentliche Kapitel-API

Diese Liste ist die Quelle für den **Lebenszyklusstatus** der exportierten
Kapitelbefehle. Die fachliche Verwendung und Auswahl beschreiben die Regeln in
`rules/20_boxes.md`, `rules/40_tables.md`, `rules/50_math.md` und
`rules/55_index.md`.

### Stabil — für neue Kapitel vorgesehen

- Struktur: `\StartChapter`, `\StartChapterOnNewColumn`, `\StartFrontChapter`,
  `\SubsectionBar`, `\SubsectionBarOnNewColumn`, `\SubsubsectionBar`,
  `\SubsubsectionBarOnNewColumn`.
- Inhaltsboxen: `defbox`, `tablebox`, `figbox`, `formulabox`, `warnbox`,
  `statementbox`, `procedure`, `factlist`, `propertylist`, `goalbox`,
  `compactgridbox`, `valuegrid`, `valuegridtwo` bis `valuegridseven`,
  `splitbox`, `runintext`.
- Tabellen: `ZSFtable`, `ZSFtableFlat`, `ZSFtablePlain`, Spaltentypen
  `L/C/R/Y/Z/Q/F`, `\ZSFheaderRow`, `\ZSFhead`.
- Bilder: `\ZSFfig`, `\ZSFfigside`, `\ZSFfigcaption`.
- Semantik und Navigation: `\ZSFkeyword`, `\ZSFdanger`, `\ZSFconclusion`,
  `\ZSFhl`, `\ZSFref`, `\ZSFsectionref`, `\ZSFTitleTag`, `\ZSFItemHeading`,
  `\ProcStep`, `\ZSFFact`.
- Formel-API: `\R`, `\C`, `\N`, `\Z`, `\Q`, `\dd`, `\vect`, `\abs`,
  `\norm`, `\ZSFsumAuto`, `\ZSFlimAuto`, `\ZSFbraceunder`,
  `\ZSFbraceover`, `\ZSFmhlA/B/C/D`, `\formulasep`, `\formulanote`,
  `\textVorBox`, `\textNachBox`, `\textVorFormel`, `\textNachFormel`.
- Goal-System: `\GoalCondition`, `\GoalStep`, `\GoalTarget`,
  `\ZSFDerivationCase`, `\ZSFDerivationInlineCase`.
- Optionale Module: die in `11_math_advanced`, `12_plots`, `65_code_style`,
  `66_index` und `67_code_comments` dokumentierten Exporte.

### Kompatibilität — vorläufig beibehalten

Diese Namen bleiben funktionsfähig, werden aber bis zur späteren Nutzungsanalyse
nicht für neue Kapitel empfohlen und ausdrücklich noch nicht entfernt:

- `fulltablebox`, `fulllessbox`, `longformula`, `valuegridcustom`;
- `\PlaceholderGraphic`, `\ZSFmanualColumnBreak`, `\ZSFtabColGap`;
- `\ZSFrowColor`, `\SetZSFtableRuleColor`, `\SetZSFtableRuleWidth`,
  `\ZSFbeginTableRuleStyle`, `\ZSFendTableRuleStyle`;
- `\GoalCard`, `\GoalPair`.

### Intern

Namen mit `ZSF@` sowie die tcolorbox-Basisstile und die Environments
`chapterbar`, `subsectionbar` und `subsubsectionbar` sind Implementierungsdetails.
Kapitel dürfen sich nicht auf sie stützen.

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
