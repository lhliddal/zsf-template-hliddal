SHELL := /bin/bash

MAIN := main.tex
BUILD_DIR := build
PDF_BASENAME ?= template_fs0000_hliddal
OUTPUT_PDF := $(PDF_BASENAME).pdf
OUTPUT_SYNC := $(PDF_BASENAME).synctex.gz
BUILD_STAMP ?= $(shell date -u +%Y%m%dT%H%M%SZ)
GIT_COMMIT ?= $(shell git rev-parse --short HEAD 2>/dev/null || echo nogit)
LATEX_DEFS := \def\ZSFBuildStamp{$(BUILD_STAMP)}\def\ZSFGitCommit{$(GIT_COMMIT)}

.PHONY: build release-proof clean all

build:
	INDEXSTYLE="$(CURDIR)/styles:" \
	latexmk -synctex=1 -interaction=nonstopmode -file-line-error -pdf -outdir=$(BUILD_DIR) -auxdir=$(BUILD_DIR) \
		-e '$$makeindex = q{makeindex -r -s zsfindex.ist %O -o %D %S};' \
		-pdflatex="pdflatex %O '$(LATEX_DEFS)\input{%S}'" $(MAIN)
	@cp $(BUILD_DIR)/main.pdf "$(OUTPUT_PDF)"
	@if [ -f "$(BUILD_DIR)/main.synctex.gz" ]; then cp "$(BUILD_DIR)/main.synctex.gz" "$(OUTPUT_SYNC)"; fi

release-proof:
	@mkdir -p $(BUILD_DIR)
	@shasum -a 256 "$(OUTPUT_PDF)" > $(BUILD_DIR)/main.pdf.sha256
	@echo "Wrote $(BUILD_DIR)/main.pdf.sha256"

clean:
	rm -rf $(BUILD_DIR)
	rm -f *.aux *.fdb_latexmk *.fls *.log *.out *.synctex.gz *.toc *.bbl *.blg *.bcf *.run.xml *.idx *.ilg *.ind

all: build
