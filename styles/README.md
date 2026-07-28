# Style Modules

Modulares Style-System, geladen von `preamble.tex` in dieser Reihenfolge:

| Modul | Inhalt |
| --- | --- |
| `00_packages.tex` | Immer aktive Basispakete und deren Setup (carlito, sansmath, mathtools, siunitx, xcolor[table], tabularx, tabularray, tcolorbox, ulem, hyperref, ...) |
| `10_math.tex` | Math-Macros: `\R \C \N \Z \Q`, `\dd`, `\norm \abs`, `\sgn \grad \divg \rot`, `\vect`, ZSFsumMode/ZSFlimMode |
| `11_math_advanced.tex` | **OPT-IN** (LinAlg/Analysis): Operatoren (`\Ker \rang \Spur \diag \spanop \eig \proj` ...), aufrechtes `\Im`/`\Re`, Klammern über Zellgrenzen (`\tikzmark`/`\drawbrace`/`\annote` + `\ZSFbraceRoom`), Pfeil-Fix |
| `12_plots.tex` | **OPT-IN**: lädt `pgfplots` und setzt die zentrale Kompatibilitätsversion |
| `20_tables.tex` | Semantisches Table-System: Spaltentypen `L/C/R/Y/Z/Q/F`, `ZSFtable` mit den Reglern `header`/`zebra`/`font`, `\ZSFheaderRow`, `\ZSFhead` |
| `30_layout_spacing.tex` | Spacing-Skala XS/S/M/L samt den globalen Stellschrauben `\ZSFDensityFactor` (Abstände) und `\ZSFLeadingFactor` (Zeilenhöhe), `\ZSFInterlude`, horizontale Innenabstände (`\ZSFboxPadX`, `\ZSFboxPadXBar`, `\ZSFtableEdgePad`), Break-Schwellwerte, `\textVorBox`/`\textNachBox` (schalten in der `formulabox` selbst um), `\ZSFRobustUnskip`, `\ZSFgap` |
| `40_colors_structure.tex` | 18-Slot-Index-Palette, semantische Farben, aktive Kapitelfarben, Flag-System, `\StartChapter`/`\StartFrontChapter` |
| `50_typography_semantics.tex` | Schriftmakros (`\ZSFfontChapter` etc., inkl. `\ZSFfontDiagramLabel`), `\ZSFkeyword`, `\ZSFlabel`, `\ZSFconclusion` |
| `55_readability.tex` | Flattersatz + TeX-Penalties für schmale Spalten (`\ZSFReadableOn`, `ZSFReadable` env, `\ZSFbreak`/`\ZSFnobreak`) |
| `60_boxes.tex` | Box-Grundvertrag (`zsfbox` → `zsfboxshape` → `zsftitlebox`, siehe unten), `chapterbar`/`subsectionbar`/`subsubsectionbar` (+ `\ZSFNewColumn`), `defbox`/`tablebox`/`figbox`/`warnbox`, `formulabox` + `\formulasep`/`\formulanote`, `runintext`, `\ZSFfig`/`\ZSFfigside`, `splitbox`, `statementbox`/`procedure`/`factlist`, `valuegrid`, Goal-System (`\GoalCondition`/`\GoalTarget`/`\ZSFDerivationCase`), Pack-Modus (`\ZSFBoxesBreakableOn`/`\ZSFBreakReservesOff`), `\ZSFdanger` |
| `65_code_style.tex` | **OPT-IN** (Informatik): lädt `listings` samt tcolorbox-Library; Style `CodeExpert`, `codebox[Titel][part=…]` (whole/first/mid/last) |
| `66_index.tex` | **OPT-IN**: lädt `makeidx`; Stichwortverzeichnis mit `\ZSFkeyword`-Auto-Indexierung, `\ZSFindex`/`\ZSFindexsee`, `x.x`-/`x.x.x`-Locator und `zsfindex.ist` |
| `67_code_comments.tex` | **OPT-IN** (Informatik, nach 65): Smart Code-Kommentare `\CodeLine{code}[comment]`, `\InlineComment`/`\OverlineComment` |
| `75_pdf_identity.tex` | PDF-Metadata (`\ZSFOwnerNameASCII`, `\ZSFSubjectTitle`, `\ZSFReleaseID`, `\ZSFBuildID`), pdfinfo + hyperref + XMP |
| `70_document_settings.tex` | wird wegen der Release-ID nach `75_pdf_identity` geladen; Linkfarben, Math-Display-Skips, Listen, Tabellen-Zellabstand sowie Footer-Overlay samt gemessenem Satzspiegel-Freiraum (`\ZSFfooterClearance`) |

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

- Struktur: `\StartChapter`, `\StartFrontChapter`, `\SubsectionBar`,
  `\SubsubsectionBar`, `\ZSFNewColumn`.
- Inhaltsboxen: `defbox`, `tablebox`, `figbox`, `formulabox`, `warnbox`,
  `statementbox`, `procedure`, `factlist`, `goalbox`,
  `valuegrid`, `splitbox`, `runintext`.
- Tabellen: `ZSFtable`, Spaltentypen
  `L`, `C`, `R`, `Y`, `Z`, `Q`, `F`, `\ZSFheaderRow`, `\ZSFhead`.
- Bilder: `\ZSFfig`, `\ZSFfigside`, `\ZSFfigcaption`.
- Semantik und Navigation: `\ZSFkeyword`, `\ZSFlabel`, `\ZSFdanger`,
  `\ZSFconclusion`, `\ZSFhl`, `\ZSFref`, `\ZSFsectionref`, `\ZSFTitleTag`,
  `\ZSFItemHeading`, `\ProcStep`, `\ZSFFact`, `\ZSFfontDiagramLabel`.
- Abstände in Kapiteln: `\ZSFgap`, `\ZSFSectionGap`.
- Punktuelle Umbruchsteuerung in Kapiteln: `\ZSFbreak`, `\ZSFnobreak`,
  `\ZSFallowbreak`.
- Dokumentkopf und Skriptverweis: `\ZSFTitleHeader`, `\ZSFScriptRef`.
- Globale Stellschrauben (in `preamble.tex`, nicht in Kapiteln):
  `\ZSFDensityFactor`, `\ZSFLeadingFactor`, `\SetZSFsumMode`, `\SetZSFlimMode`, `\SetZSFzebraBG`,
  `\ZSFReadableBodyOn`, `\ZSFReadableBodyOff`, `\ZSFIndexShowPageNumber`
  (Index-Locator mit oder ohne Seitenzahl, siehe `rules/55_index.md`).
- Pack-Modus für Anhang-artige Kapitel (am Kapitelanfang):
  `\ZSFBoxesBreakableOn`, `\ZSFBoxesBreakableOff`, `\ZSFBreakReservesOff`.
- Formel-API: `\R`, `\C`, `\N`, `\Z`, `\Q`, `\dd`, `\vect`, `\abs`,
  `\norm`, `\ZSFsumAuto`, `\ZSFlimAuto`, `\ZSFbraceunder`,
  `\ZSFbraceover`, `\ZSFmhlA`, `\ZSFmhlB`, `\ZSFmhlC`, `\ZSFmhlD`,
  `\formulasep`, `\formulanote`,
  `\ZSFformulaline`,
  `\textVorBox`, `\textNachBox`.
- Goal-System: `\GoalCondition`, `\GoalStep`, `\GoalTarget`,
  `\ZSFDerivationCase`.
- Optionale Module: die in `11_math_advanced`, `12_plots`, `65_code_style`,
  `66_index` und `67_code_comments` dokumentierten Exporte.

### Kompatibilität — bereinigt

Die früher hier geführten Namen sind **entfernt**. Die Nutzungsanalyse über
Showcase und alle Fach-ZSF zeigte durchweg Redundanz oder Nullnutzung; jede
Funktion bleibt über einen stabilen Baustein erreichbar:

| entfernt | Ersatz |
| --- | --- |
| `valuegridtwo` … `valuegridseven`, `valuegridcustom` | `valuegrid[Titel]{n}` |
| `compactgridbox` | intern geworden — Zugriff über `valuegrid` |
| `fulltablebox`, `fulllessbox` | `tablebox` + `ZSFtable` |
| `longformula` | `\[ \begin{aligned} … \end{aligned} \]` in `formulabox` |
| `\GoalCard`, `\GoalPair` | `goalbox` + `\GoalCondition`/`\GoalStep`/`\GoalTarget` |
| `\PlaceholderGraphic` | `\ZSFfig` |
| `\ZSFmanualColumnBreak` | `\ZSFNewColumn` |
| `\ZSFtabColGap`, `\ZSFrowColor`, `\SetZSFtableRule*`, `\ZSF*TableRuleStyle` | zentrale `ZSFtable`-Stile |
| `ZSFtableFlat`, `ZSFtablePlain` | `ZSFtable[header=false]`, `ZSFtable[header=false, zebra=false]` |
| `codeboxfirst`, `codeboxmid`, `codeboxlast` | `codebox[Titel][part=first\|mid\|last]` |
| `\ZSFfigrow` | `\ZSFfig` mit einer Pfadliste |
| `\StartChapterOnNewColumn`, `\SubsectionBarOnNewColumn`, `\SubsubsectionBarOnNewColumn` | `\ZSFNewColumn` vor dem Strukturmakro |
| `\ZSFDerivationInlineCase` | `\ZSFDerivationCase*` |
| `\ZSFgapXS`, `\ZSFgapS`, `\ZSFgapM`, `\ZSFgapL` | `\ZSFgap[XS\|S\|M\|L]` |
| `\textVorFormel`, `\textNachFormel` | `\textVorBox`/`\textNachBox` (schalten in der `formulabox` selbst um) |

Fach-Forks mit eigenen Style-Kopien sind davon nicht betroffen; sie behalten,
was sie mitgebracht haben (siehe `rules/00_meta.md` → Verhältnis zu Forks).

### Intern

**Die Stabil-Liste oben ist abschliessend: Was dort nicht steht, ist intern** —
unabhängig vom Namen. Das `ZSF@`-Präfix markiert nur einen Teil der Internas;
viele heissen aus historischen Gründen schlicht `ZSF…` und sehen dadurch
öffentlich aus. Beispiele für Internas ohne Präfix: die Farb-Tokens
(`\BoxTitleColor`, `\SubsectionBarColor`, …), die Balken-Hooks
(`\ZSFConsumeAfterSubsectionBar`, `\ZSFMarkAfterSubsectionBar`), die
Spacing-Register (`\ZSFboxPadX`, `\ZSFbarPadY`, …) und die Schriftmakros
(`\ZSFfontBoxTitle`, …).

Ebenfalls intern: die tcolorbox-Basisstile (`zsfbox`, `zsfboxshape`,
`zsftitlebox`, `zsfbar`, `zsfvaluegridshell`, …) und die Environments
`chapterbar`, `subsectionbar`, `subsubsectionbar`.

Kapitel dürfen sich auf nichts davon stützen. Style-Module dürfen und sollen es.

### Der Box-Grundvertrag (für Style-Autoren)

Jede Inhaltsbox steht auf **drei** Schichten in `60_boxes.tex` und setzt danach
nur noch, worin sie sich wirklich unterscheidet:

| Schicht | Verantwortung |
| --- | --- |
| `zsfbox` | Fluss — Skips (`\ZSFBoxBeforeSkip`/`\ZSFBoxAfterSkip`) und Eintritts-Hook (Balken-Bindung). Auch rahmenlose Boxen laufen hierüber. |
| `zsfboxshape` | Form — Rahmenstärke, Ecken, `boxsep`, Innenabstand, `breakable`. **Die eine Stelle für die Geometrie aller Boxen.** |
| `zsftitlebox` | Titelbox — Farbtokens, Titelbalken (`zsftitlebar`), Lesbarkeit. |

`defbox`, `tablebox`, `figbox`, `warnbox`, `formulabox`, `goalbox`, `valuegrid`
und `codebox` sind Ableitungen von `zsftitlebox`; `statementbox` leitet von
`zsfboxshape` ab und nimmt Rahmen und Ecken zurück.

Wer eine neue Box anlegt, erweitert eine dieser Schichten und zählt ihre
Schlüssel **nicht** erneut auf (Begründung: `rules/10_architecture.md` → „Beim
Editieren von `styles/*.tex`"). Prüffrage: *Eckenradius aller Boxen ändern —
reicht eine Zeile?*

Alle Titelboxen laufen über die Fabrik `ZSF@box`. Sie schaltet bei leerem Titel
auf `notitle` um — deshalb braucht keine Box mehr eine titellose Zweitfassung.

#### Box-Optionen (zweites optionales Argument)

Diese Schlüssel sind Teil der stabilen API, aber keine Makros — sie stehen
deshalb nicht in der Token-Liste oben:

| Schlüssel | Boxen | Werte (Default zuerst) |
| --- | --- | --- |
| `tone` | alle Titelboxen | `chapter`, `neutral`, `warn` |
| `part` | `codebox` | `whole`, `first`, `mid`, `last` |
| `split ratio` | `splitbox` | Anteil der linken Hälfte, Default `0.3` |
| `header` | `ZSFtable` | `true`, `false` |
| `zebra` | `ZSFtable` | `true`, `false` |
| `font` | `ZSFtable` | `normal`, `dense` |

Darüber hinaus ist jeder tcolorbox-Schlüssel erlaubt (`breakable`,
`sidebyside align=center`, …) — das zweite optionale Argument wird
unverändert an tcolorbox durchgereicht.

Zwei Boxen erzwingen ihr Umbruchverhalten mit `unbreakable` **nach**
`zsftitlebox` (`figbox`, `goalbox`, `valuegrid`), damit der Pack-Modus
(`\ZSFBoxesBreakableOn`) sie nicht aufbricht.

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
