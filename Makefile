SHELL := /bin/bash

MAIN := main.tex
BUILD_DIR := build
PDF_BASENAME ?= template_fs0000_hliddal
OUTPUT_PDF := $(PDF_BASENAME).pdf
OUTPUT_SYNC := $(PDF_BASENAME).synctex.gz
SYNCTEX ?= 1
LATEXMK_FORCE ?=
LATEXMK_FLAGS := -interaction=nonstopmode -file-line-error -pdf
ifeq ($(SYNCTEX),1)
LATEXMK_FLAGS += -synctex=1
endif

# Identity (Forks überschreiben diese; müssen zu styles/75_pdf_identity.tex passen).
SUBJECT_TITLE ?= ZSF Template
RELEASE_ID    ?= R0000.00
BUILD_STAMP ?= $(shell date -u +%Y%m%dT%H%M%SZ)
GIT_COMMIT ?= $(shell git rev-parse --short HEAD 2>/dev/null || echo nogit)
LATEX_DEFS := \def\ZSFSubjectTitle{$(SUBJECT_TITLE)}\def\ZSFReleaseID{$(RELEASE_ID)}\def\ZSFBuildStamp{$(BUILD_STAMP)}\def\ZSFGitCommit{$(GIT_COMMIT)}

# Optional local-only automation; Makefile.local is gitignored.
-include Makefile.local

.PHONY: build rebuild check clean all \
        check-main-full check-chapters check-tables check-refs check-index check-init-project \
        check-root-clean check-pdf-identity check-guardrails lint \
        sync-rules check-rules check-rule-authorship \
        release-proof print-pdf-basename

build:
	INDEXSTYLE="$(CURDIR)/styles:" \
	latexmk $(LATEXMK_FORCE) $(LATEXMK_FLAGS) -outdir=$(BUILD_DIR) -auxdir=$(BUILD_DIR) \
		-e '$$makeindex = q{makeindex -r -s zsfindex.ist %O -o %D %S};' \
		-pdflatex="pdflatex %O '$(LATEX_DEFS)\input{%S}'" $(MAIN)
	@cp $(BUILD_DIR)/main.pdf "$(OUTPUT_PDF)"
	@if [ "$(SYNCTEX)" = "1" ] && [ -f "$(BUILD_DIR)/main.synctex.gz" ]; then cp "$(BUILD_DIR)/main.synctex.gz" "$(OUTPUT_SYNC)"; fi

rebuild: LATEXMK_FORCE := -g
rebuild: build

# --- Verifier ----------------------------------------------------------
# 'make check' ist das lokale Feedback-Loop: Struktur-, Tabellen-, Ref-,
# Index-, Root-, PDF-Identity-, Guardrail-, Lint- und Rule-Drift-Prüfung.
# check-pdf-identity und die .ind-Prüfungen brauchen einen vorherigen Build
# (also: `make build && make check`).
# Läuft NICHT in CI: tests/ tools/ rules/ sind git-excluded und fehlen im Clone.
# 'make check' ist der lokale Gate (+ pre-commit); CI baut nur das PDF.
check: check-main-full check-chapters check-tables check-refs check-index \
       check-root-clean check-pdf-identity check-guardrails lint \
       check-rule-authorship check-rules
	@echo "make check: alle Prüfungen bestanden."

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

# Template-spezifischer, separater E2E-Test: initialisiert und baut eine
# temporäre Kopie, ohne den normalen Fachprojekt-Check zu verteuern.
check-init-project:
	@bash tests/check_init_project.sh

check-root-clean:
	@PDF_BASENAME="$(PDF_BASENAME)" bash tests/check_root_clean.sh

check-pdf-identity:
	@PDF_FILE="$(OUTPUT_PDF)" SUBJECT_TITLE="$(SUBJECT_TITLE)" RELEASE_ID="$(RELEASE_ID)" bash tests/check_pdf_identity.sh

check-guardrails:
	@bash tests/check_guardrails.sh

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

release-proof:
	@mkdir -p $(BUILD_DIR)
	@shasum -a 256 "$(OUTPUT_PDF)" > $(BUILD_DIR)/main.pdf.sha256
	@echo "Wrote $(BUILD_DIR)/main.pdf.sha256"

clean:
	rm -rf $(BUILD_DIR)
	rm -f *.aux *.fdb_latexmk *.fls *.log *.out *.synctex.gz *.toc *.bbl *.blg *.bcf *.run.xml *.idx *.ilg *.ind

all: build
