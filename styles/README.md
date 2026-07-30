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
| `60_boxes.tex` | Box-Grundvertrag (`zsfbox` → `zsfboxshape` → `zsftitlebox`, siehe unten), Instanz-Regler (`tone`/`weight`/`padx`/`pady`/`align`/`frame`/`atomic`/`split`), `chapterbar`/`subsectionbar`/`subsubsectionbar` (+ `\ZSFNewColumn`), `defbox`/`tablebox`/`figbox`/`warnbox`, `formulabox` + `\ZSFsep`/`\formulanote`, `runintext`, `\ZSFfig`/`\ZSFfigside`, `splitbox`, `ZSFlist` + `\ZSFItem`, `valuegrid`, Goal-System (`\GoalCondition`/`\GoalTarget`/`\ZSFDerivationCase`), Pack-Modus (`\ZSFBoxesBreakableOn`/`\ZSFBreakReservesOff`), `\ZSFdanger` |
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
`rules/20_boxes.md` (Katalog), `rules/21_box_options.md` (Regler),
`rules/25_structure_markers.md`, `rules/40_tables.md`, `rules/50_math.md`
und `rules/55_index.md`.

### Stabil — für neue Kapitel vorgesehen

- Struktur: `\StartChapter`, `\StartFrontChapter`, `\SubsectionBar`,
  `\SubsubsectionBar`, `\ZSFNewColumn`.
- Inhaltsboxen: `defbox`, `tablebox`, `figbox`, `formulabox`, `warnbox`,
  `ZSFlist`, `goalbox`, `valuegrid`, `splitbox`, `runintext`.
- Tabellen: `ZSFtable`, Spaltentypen
  `L`, `C`, `R`, `Y`, `Z`, `Q`, `F`, `\ZSFheaderRow`, `\ZSFhead`.
- Bilder: `\ZSFfig`, `\ZSFfigside`, `\ZSFfigcaption`.
- Semantik und Navigation: `\ZSFkeyword`, `\ZSFlabel`, `\ZSFdanger`,
  `\ZSFconclusion`, `\ZSFhl`, `\ZSFref`, `\ZSFsectionref`, `\ZSFTitleTag`,
  `\ZSFsep`, `\ZSFItem`, `\ZSFfontDiagramLabel`.
- Abstände in Kapiteln: `\ZSFgap`, `\ZSFSectionGap`.
- Punktuelle Umbruchsteuerung in Kapiteln: `\ZSFbreak`, `\ZSFnobreak`,
  `\ZSFallowbreak`.
- Dokumentkopf und Skriptverweis: `\ZSFTitleHeader`, `\ZSFScriptRef`.
- Globale Stellschrauben (in `preamble.tex`, nicht in Kapiteln):
  `\ZSFDensityFactor`, `\ZSFLeadingFactor`,
  Bereichsfaktoren `\ZSFDensityBoxes`, `\ZSFDensityText`, `\ZSFDensityTables`,
  `\ZSFDensityStructure`, `\ZSFBreakReserveFactor` (siehe `rules/30_spacing.md`),
  `\SetZSFsumMode`, `\SetZSFlimMode`, `\SetZSFzebraBG`,
  `\ZSFReadableBodyOn`, `\ZSFReadableBodyOff`, `\ZSFIndexShowPageNumber`
  (Index-Locator mit oder ohne Seitenzahl, siehe `rules/55_index.md`),
  `\ZSFkeywordStyle`, `\ZSFlabelStyle` (Darstellung der beiden Marker).
- Pack-Modus für Anhang-artige Kapitel (am Kapitelanfang):
  `\ZSFBoxesBreakableOn`, `\ZSFBoxesBreakableOff`, `\ZSFBreakReservesOff`.
- Formel-API: `\R`, `\C`, `\N`, `\Z`, `\Q`, `\dd`, `\vect`, `\abs`,
  `\norm`, `\ZSFsumAuto`, `\ZSFlimAuto`, `\ZSFbraceunder`,
  `\ZSFbraceover`, `\ZSFmhlA`, `\ZSFmhlB`, `\ZSFmhlC`, `\ZSFmhlD`,
  `\formulanote`,
  `\ZSFformulaline`,
  `\textVorBox`, `\textNachBox`.
- Goal-System: `\GoalCondition`, `\GoalStep`, `\GoalTarget`,
  `\ZSFDerivationCase`.
- Optionale Module: die in `11_math_advanced`, `12_plots`, `65_code_style`,
  `66_index` und `67_code_comments` dokumentierten Exporte.

### Entwicklungsrichtung

Diese Liste soll **kürzer** werden, nicht länger — und die Regler-Tabelle
weiter unten **länger**. Zwei Sätze, die unabhängig voneinander gelten:

1. **Bausteine werden nach Ermessen weiter zusammengelegt.** Ein Name muss
   eine eigene, nicht ableitbare Absicht tragen. Wo zwei Namen dieselbe
   Absicht bedienen, verschwindet einer — zuletzt `statementbox` (jetzt
   `weight=quiet`) und `procedure`/`factlist` (jetzt `ZSFlist[ordered]`).
2. **Variabilität wird ausgebaut, bedingungslos.** Jede in `styles/` fest
   verdrahtete Eigenschaft, die pro Stelle sinnvoll anders sein könnte, wird
   zu einem benannten Regler — auch ohne anstehende Zusammenlegung.

Wer hier etwas einträgt, prüft zuerst, ob ein Regler an einem vorhandenen
Baustein denselben Fall trägt (`rules/21_box_options.md`).

Zwei Testfragen entscheiden den Einzelfall:

- **Vereinigungstest:** Müsste eine Verbesserung an Baustein A anschliessend an
  Baustein B nachgezogen werden? Dann sind A und B ein Baustein mit einem Regler.
- **Reglertest:** Drückt der Regler eine Entscheidung aus, die der Autor pro
  Stelle tatsächlich trifft? Oder folgt sie zwingend aus der Inhaltsart? Nur im
  ersten Fall ist es ein Regler; im zweiten gehört sie in eine Vorbelegung.

### Bewusst getrennt gehaltene Bausteine

Diese vier haben die Prüfung bestanden und bleiben **absichtlich** eigene Namen.
Wer sie zusammenlegen will, argumentiert gegen die hier genannte Absicht — nicht
gegen ein Versehen.

| Baustein | eigene Absicht | technisch wäre es |
| --- | --- | --- |
| `warnbox` | »Stolperfalle« ist die meistgesuchte Kategorie einer Prüfungs-ZSF; der vorbelegte Titel macht die Box ohne jedes Argument vollständig | `defbox[…][tone=warn]` |
| `figbox` | „hier steht eine Abbildung" — der Container für selbstgezeichnete Diagramme | `defbox[…][atomic]` |
| `goalbox` | „hier wird hergeleitet" — die Kombination aus vier Reglern ist nicht ableitbar, und Komponieren ist genau das Entwerfen, das die KI nicht tun soll | `defbox[…][align=center, pady=tight, frame=strong, atomic]` |
| `splitbox` | der rahmenlose Zweispalter ist der häufigste Split-Fall und wäre sonst vier Optionen lang | `defbox[][split=…, frame=none, padx=none, pady=none]` |

Gemeinsames Muster: Jeder ist ein **Ein-Zeilen-Preset** über demselben
Reglersatz — ein Name, der nur eine Vorbelegung benennt, kostet fast nichts und
erspart der KI das Komponieren.

`warnbox` ist dabei die einzige Box, die einen **Ton** als eigenen Namen führt.
Das ist eine benannte Ausnahme, kein Muster: Ein weiterer Ton bekommt keine
eigene Umgebung, solange er nicht beides mitbringt — eigene Semantik **und**
eine sinnvolle Vorbelegung.

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
| `statementbox` | `defbox[Titel][weight=quiet]` |
| `procedure` + `\ProcStep` | `ZSFlist[Titel][ordered]` + `\ZSFItem` |
| `factlist` + `\ZSFFact` | `ZSFlist[Titel]` + `\ZSFItem` |
| `split ratio=…` | `split=…` (gilt jetzt auf jeder Box, nicht nur `splitbox`) |
| `\ZSFfig[<Anteil>]`, `\ZSFfigside[<Anteil>]` | `\ZSFfig[width=…, height=…]`, `\ZSFfigside[width=…]` |
| `\formulasep`, `\ZSFItemHeading` | `\ZSFsep` bzw. `\ZSFsep[Beschriftung]` |

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
und `codebox` sind Ableitungen von `zsftitlebox`; `preset/quiet` (via
`weight=quiet`) leitet von `zsfboxshape` ab und nimmt Rahmen und Ecken zurück.

**Der `tone`-Regler hat zwei Landepunkte, nicht einen.** Ein Ton setzt die
Schlüssel der Titelbox-Familie (`colbacktitle`, `colframe`, `coltitle`) und
zusätzlich zwei Makros für die rahmenlose Familie: `\ZSFtoneAccent` (Balken,
Titelzeile, Aufzählungszeichen) und `\ZSFtoneQuietBack` (Fläche). Welchen
Landepunkt eine Box liest, entscheidet ihr Stil — dadurch genügt **ein**
Regler, und die leise Box bleibt im Kapitelton trotzdem ungetönt. Die
Farbtokens dazu stehen in `40_colors_structure` (`\ZSFtoneAccent*`,
`\ZSFtoneLoudBack*`, `\ZSFtoneQuietBack*`).

**Die Fläche setzt der Ton nicht als einen Wert, sondern als beide** — laut und
ruhig, über den Schlüssel `ZSF@toneSurface`. Welche davon gilt, entscheidet die
Gewicht-Wahl, die zu diesem Zeitpunkt bereits feststeht. Grund ist dieselbe
tcolorbox-Mechanik wie beim Rahmen: `colback` wird sofort per `\colorlet`
aufgelöst und gehört damit dem letzten Schreiber. Setzten Ton und Gewicht es
beide, entschiede die Reihenfolge im Aufruf — und ein ausgeschriebenes
`tone=chapter` tönte eine leise Box, ein weggelassenes nicht.

**`weight` wird von der Fabrik vorab gelesen, nicht in der Optionsliste
ausgewertet.** Es ist der einzige Regler, der keinen Wert wählt, sondern den
**Basisstil** — und ein Basisstil bringt Vorbelegungen mit (`padx=bar`,
`frame=none`, `align=left`, …). Stünde er wie die übrigen Regler in der
Aufrufer-Liste, liefen diese Vorbelegungen nach den Wahlen des Aufrufers und
überschrieben sie: `[tone=warn, weight=quiet]` verlor den Ton,
`[frame=strong, weight=quiet]` den Rahmen — beides stumm, weil jeder Wert für
sich gültig ist. `ZSF@box` liest die Wahl deshalb per `pgfkeys`-Vorlauf aus dem
Aufruf und setzt die fertige Basis (`ZSF@weightBase`) **vor** die
Aufrufer-Optionen. Wer einen weiteren Regler dieser Art anlegt, macht es
genauso. Geprüft wird das von `tests/check_box_options.sh`.

**Die Rahmenfarbe setzt der Ton direkt, obwohl es dafür auch Makros gibt.**
Das ist keine Doppelung, sondern Folge der tcolorbox-Mechanik: `colframe` wird
beim Setzen der Option sofort per `\colorlet` aufgelöst, nicht erst beim
Zeichnen. Ein `colframe=\Makro` friert deshalb den Wert ein, den das Makro an
dieser Stelle der Optionsliste hat. `\ZSFtoneAccent` funktioniert dagegen als
reines Makro, weil `borderline` seine Farbe erst beim Zeichnen ausliest.

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
| `tone` | alle Boxen | `chapter`, `neutral`, `warn` |
| `weight` | alle Boxen mit Titel | `loud`, `quiet` |
| `padx` | alle Boxen | `normal`, `bar`, `none` |
| `pady` | alle Boxen | `normal`, `tight`, `quiet`, `none` |
| `align` | alle Boxen | `left`, `center` |
| `frame` | alle Boxen | `soft`, `strong`, `hard`, `none` |
| `atomic` | alle Boxen | Flag |
| `split` | alle Boxen | Anteil der linken Hälfte |
| `ordered` | `ZSFlist` | Flag |
| `bodyparskip` | alle Boxen | `box` (eigener Absatzabstand), `inherit` (Dokumentwert) |
| `part` | `codebox` | `whole`, `first`, `mid`, `last` |
| `header` | `ZSFtable` | `true`, `false` |
| `zebra` | `ZSFtable` | `true`, `false` |
| `font` | `ZSFtable` | `normal`, `dense` |

Diese Tabelle ist die Quelle für zwei Durchgänge von
`check_showcase_coverage.sh`. **Durchgang 3:** Jeder Schlüssel muss in einer
`rules/*.md` beschrieben sein — ein Regler, den nur diese Datei kennt,
existiert für eine KI nicht. **Durchgang 4:** Jeder Wert ausser der
Vorbelegung muss in `chapters/` an einer Box gesetzt sein; eine blosse
Erwähnung im Titel-Tag oder im Fliesstext zählt nicht. Für Bausteine gilt seit
Durchgang 1, dass Behaupten nicht genügt — für die Liste, die laut
Entwicklungsrichtung **wachsen** soll, gilt es damit auch.

Die Spaltenreihenfolge ist deshalb bindend: Spalte 1 der Schlüssel, Spalte 3
die Werte mit der **Vorbelegung zuerst**. Ein neuer Regler wird hier
eingetragen, in einer `rules/*.md` beschrieben und in `chapters/` vorgeführt —
sonst bricht `make check`.

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
