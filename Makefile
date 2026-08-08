SHELL := /bin/bash

MAIN := main.tex
BUILD_DIR := build
PDF_BASENAME ?= template_fs0000_hliddal
OUTPUT_PDF := $(PDF_BASENAME).pdf
OUTPUT_SYNC := $(PDF_BASENAME).synctex.gz
SYNCTEX ?= 1
LATEXMK_FORCE ?=
LATEXMK_FLAGS := -interaction=nonstopmode -file-line-error -lualatex
ifeq ($(SYNCTEX),1)
LATEXMK_FLAGS += -synctex=1
endif

# Legacy-Modus für BESTEHENDE ZSF, die nicht auf den aktuellen Stand umgebaut
# werden: ZSF_LEGACY = 1 stuft Kapitel-Regelbefunde zu Hinweisen herab, damit
# der Build grün bleibt. Die Befunde bleiben sichtbar und werden gezählt.
# Im Template und in jeder neu aufgebauten ZSF bleibt der Wert 0.
ZSF_LEGACY ?= 0
export ZSF_LEGACY

# Identity (Forks überschreiben diese; müssen zu styles/75_pdf_identity.tex passen).
SUBJECT_TITLE ?= ZSF Template
LOCAL_BUILD_DATE ?= $(shell date +%Y-%m-%d)
RELEASE_ID ?= DEV-$(LOCAL_BUILD_DATE)
RELEASE_LABEL = $(subst DEV-,DEV\space\textperiodcentered\space ,$(RELEASE_ID))
BUILD_STAMP ?= $(shell date -u +%Y%m%dT%H%M%SZ)
GIT_COMMIT ?= $(shell git rev-parse --short HEAD 2>/dev/null || echo nogit)
LATEX_DEFS := \def\ZSFSubjectTitle{$(SUBJECT_TITLE)}\def\ZSFReleaseID{$(RELEASE_ID)}\def\ZSFReleaseLabel{$(RELEASE_LABEL)}\def\ZSFBuildStamp{$(BUILD_STAMP)}\def\ZSFGitCommit{$(GIT_COMMIT)}
IDENTITY_STAMP := $(BUILD_DIR)/.zsf-identity
IDENTITY_KEY := $(RELEASE_ID)|$(GIT_COMMIT)
IDENTITY_FORCE := $(shell if [ ! -f "$(IDENTITY_STAMP)" ] || [ "$$(cat "$(IDENTITY_STAMP)")" != "$(IDENTITY_KEY)" ]; then printf '%s' '-g'; fi)

# Optional local-only automation; Makefile.local is gitignored.
-include Makefile.local

.PHONY: build rebuild check check-deep check-all clean all \
        check-main-full check-chapters check-tables check-refs check-index check-styles check-optional-modules check-init-project \
        check-root-clean check-pdf-identity check-guardrails check-showcase-coverage check-box-options \
        check-global-knobs check-ink-contract check-spacing-registers check-scopes lint \
        sync-rules check-rules check-rule-authorship \
        release-proof print-pdf-basename print-release-id

# Index: upmendex statt makeindex (ICU sortiert Umlaute nach DIN 5007-1 ohne
# Sortkeys, rules/55_index). Die ||-Weiche gleicht EINEN Verhaltensunterschied
# aus: Bei leerem .idx (frischer Fork, Modul 66 aktiv, noch kein Eintrag)
# schreibt upmendex nichts und beendet mit Fehler, wo makeindex still eine
# leere .ind schrieb — dann ist die leere .ind korrekt und kein Fehler.
# Bei echtem Fehler (Einträge vorhanden, Lauf scheitert) bricht der Build.
build:
	INDEXSTYLE="$(CURDIR)/styles:" \
	latexmk $(LATEXMK_FORCE) $(IDENTITY_FORCE) $(LATEXMK_FLAGS) -outdir=$(BUILD_DIR) -auxdir=$(BUILD_DIR) \
		-e '$$makeindex = q{upmendex -r -s zsfindex.ist %O -o %D %S || { test ! -s %S && touch %D; }};' \
		-pdflualatex="lualatex %O '$(LATEX_DEFS)\input{%S}'" $(MAIN)
	@cp $(BUILD_DIR)/main.pdf "$(OUTPUT_PDF)"
	@if [ "$(SYNCTEX)" = "1" ] && [ -f "$(BUILD_DIR)/main.synctex.gz" ]; then cp "$(BUILD_DIR)/main.synctex.gz" "$(OUTPUT_SYNC)"; fi
	@printf '%s\n' "$(IDENTITY_KEY)" > "$(IDENTITY_STAMP)"

rebuild: LATEXMK_FORCE := -g
rebuild: build

# --- Verifier: drei Stufen ---------------------------------------------
# 'make check'      — Alltags-Gate (<30 s): Build + alle Schnellprüfungen
#                     (Struktur, Tabellen, Refs, Index, Style-Tokens, Root,
#                     PDF-Identity, Guardrails, Showcase, Scopes, Lint,
#                     Rule-Drift). Meldet veraltete Tiefenprüfungen am Ende,
#                     führt sie aber NICHT aus — das Alltags-Budget gehört
#                     dem Arbeitsfluss (tests/README.md → Stufen).
# 'make check-deep' — die Satz-Verifier (Box-Regler, Spacing-Register,
#                     Stellschrauben, Ink-Vertrag, Modul-Isolation). Läuft
#                     nur, was seit dem letzten grünen Lauf veraltet ist
#                     (Stempel in build/checkstamps/), parallel. FORCE=1
#                     erzwingt alle. Fällig nach Arbeit an styles/ oder
#                     preamble.tex.
# 'make check-all'  — vor Push/Release: check + check-deep + Fork-E2E.
# 'check' baut zuerst: check-pdf-identity und die .ind-Prüfungen brauchen ein
# aktuelles PDF. Der Build ist inkrementell und damit fast gratis, wenn nichts
# geändert wurde — dafür kann 'make check' nicht mehr an einem PDF von gestern
# scheitern (RELEASE_ID trägt das Build-Datum).
# Läuft NICHT in CI: tests/ tools/ rules/ sind git-excluded und fehlen im Clone.
check: build check-main-full check-chapters check-tables check-refs check-index check-styles \
       check-root-clean check-pdf-identity check-guardrails check-showcase-coverage \
       check-scopes lint check-rule-authorship check-rules
	@bash tests/run_deep_checks.sh status
	@echo "make check: alle Schnellprüfungen bestanden."

check-deep:
	@bash tests/run_deep_checks.sh run

check-all: check check-deep check-init-project
	@echo "make check-all: alle Prüfungen bestanden."

check-main-full:
	@bash tests/check_main_full.sh

check-chapters:
	@bash tests/check_chapter_rules.sh

check-tables:
	@node tests/check_table_colspecs.mjs

check-refs:
	@bash tests/check_refs.sh

check-index:
	@bash tests/check_index.sh

check-styles:
	@bash tests/check_style_tokens.sh

# Tiefenprüfung — läuft über den Stempel-Treiber (FORCE=1 erzwingt).
check-optional-modules:
	@bash tests/run_deep_checks.sh run optional-modules

# E2E-Test des Fork-Generators: initialisiert und baut eine temporäre Kopie.
# Teil von 'make check', weil ein sauberer Fork die erste Pflicht des
# Templates ist (rules/00_meta) — ein separat aufzurufender Test dafür bleibt
# unbemerkt rot. In einem Fach-Fork ohne scripts/ ist er ein No-op.
check-init-project:
	@if [ -f scripts/init_project.sh ]; then bash tests/check_init_project.sh; \
	else echo "check-init-project: kein Fork-Generator vorhanden — übersprungen."; fi

check-root-clean:
	@PDF_BASENAME="$(PDF_BASENAME)" bash tests/check_root_clean.sh

check-pdf-identity: build
	@PDF_FILE="$(OUTPUT_PDF)" SUBJECT_TITLE="$(SUBJECT_TITLE)" RELEASE_ID="$(RELEASE_ID)" bash tests/check_pdf_identity.sh

check-guardrails:
	@bash tests/check_guardrails.sh

check-showcase-coverage:
	@bash tests/check_showcase_coverage.sh

# Prüft die Regler-Zusage aus rules/21_box_options.md am laufenden Satz:
# jedes Reglerpaar in beiden Reihenfolgen, und jeder Reglerwert gegen die
# Vorbelegung. Beide Fehlerarten sind stumm und deshalb nur so zu finden.
check-box-options:
	@bash tests/run_deep_checks.sh run box-options

# Das Gegenstück eine Ebene höher: dreht jede globale Stellschraube einzeln und
# verlangt eine messbare Wirkung. Ohne diesen Lauf war ausgerechnet die Ebene
# ungeprüft, die pro ZSF tatsächlich verstellt wird.
check-global-knobs:
	@bash tests/run_deep_checks.sh run global-knobs

# Belegt den Ink-Vertrag am Satz: Auf einer Flaeche, die ihre eigene
# Kontrastfarbe setzt, muss ein farbtragender Marker sie abgeben — und im
# freien Boxinhalt behalten. Die zweite Haelfte ist die Negativkontrolle;
# ohne sie bestuende der Lauf auch, wenn die Farbe ueberall verlorenginge.
check-ink-contract:
	@bash tests/run_deep_checks.sh run ink-contract

# Die Ebene unter den Stellschrauben: dreht jedes Spacing-Register einzeln und
# verlangt eine Wirkung am Satz, haelt die Fremdparameter an ihr Register und
# prueft die Umbruchreserve am echten Dokument. Anlass war ein Register, das
# jahrelang niemand las, ohne dass es im Code danach aussah.
check-spacing-registers:
	@bash tests/run_deep_checks.sh run spacing-registers

# Die dritte Achse: nicht "wirkt jeder Regler", sondern "welche
# Geltungsbereiche gibt es ueberhaupt". check-box-options prueft
# Vollstaendigkeit INNERHALB der Box-Ebene und kann einen FEHLENDEN Bereich
# konstruktionsbedingt nicht sehen — dort lagen aber alle Luecken, die die
# Analyse der Fach-ZSF gefunden hat.
check-scopes:
	@bash tests/check_scopes.sh

# chktex ist stilistischer Lint (advisory): meldet, bricht den Build aber nicht.
# Der harte Lint-Gate auf geänderten Dateien läuft über pre-commit.
lint:
	@command -v chktex >/dev/null 2>&1 || { echo "lint: chktex nicht installiert — übersprungen."; exit 0; }
	@chktex -q -n1 -n3 -n6 -n8 -n12 -n13 -n18 -n35 -n36 -n44 main.tex preamble.tex chapters/*.tex || true

# --- KI-Regeln: eine Quelle (rules/*.md) -> AGENTS.md (+ Symlinks + cursor) --
sync-rules:
	@node tools/sync-agent-rules.mjs

check-rules:
	@node tools/sync-agent-rules.mjs --check

check-rule-authorship:
	@node tools/check-rule-authorship.mjs

print-pdf-basename:
	@echo "$(PDF_BASENAME)"

print-release-id:
	@echo "$(RELEASE_ID)"

release-proof:
	@mkdir -p $(BUILD_DIR)
	@shasum -a 256 "$(OUTPUT_PDF)" > $(BUILD_DIR)/main.pdf.sha256
	@echo "Wrote $(BUILD_DIR)/main.pdf.sha256"

clean:
	rm -rf $(BUILD_DIR)
	rm -f *.aux *.fdb_latexmk *.fls *.log *.out *.synctex.gz *.toc *.bbl *.blg *.bcf *.run.xml *.idx *.ilg *.ind

all: build
