TYPST_COMMAND = typst
PYTHON = python
OUTPUT_DIR = ./build

CUTTING_LINE_SRC = cutting_line_a4.typ
CUTTING_LINE_PDF = $(OUTPUT_DIR)/cutting_line_a4.pdf
A4_SRC = src_a4.typ
A4_PDF = $(OUTPUT_DIR)/glossary_a4.pdf
A5_PDF = $(OUTPUT_DIR)/glossary_a5.pdf
A4_SHORT_A5_PDF = $(OUTPUT_DIR)/glossary_a4_short_side_a5.pdf
A4_LONG_A5_PDF  = $(OUTPUT_DIR)/glossary_a4_long_side_a5.pdf

all: $(A4_PDF) $(A5_PDF) $(A4_SHORT_A5_PDF) $(A4_LONG_A5_PDF)


$(A4_PDF): $(A4_SRC) | $(OUTPUT_DIR)
	$(TYPST_COMMAND) compile $< $@


a4_page_cnt = $(shell $(PYTHON) get_pdf_page_cnt.py --input $(A4_PDF))
$(A5_PDF): $(A4_PDF)
	$(TYPST_COMMAND) compile export_a5.typ $@ --input in=$< --input page_cnt=$(a4_page_cnt)

$(A4_SHORT_A5_PDF): $(A4_PDF)
	$(TYPST_COMMAND) compile export_a4_short_side_a5.typ $@ --input in=$< --input page_cnt=$(a4_page_cnt)

$(A4_LONG_A5_PDF): $(A4_PDF)
	$(TYPST_COMMAND) compile export_a4_long_side_a5.typ $@ --input in=$< --input page_cnt=$(a4_page_cnt)

$(OUTPUT_DIR):
	mkdir -p $@

build_a4: $(A4_PDF)
build_a5: $(A5_PDF)
build_a4_short_side_a5: $(A4_SHORT_A5_PDF)
build_a4_long_side_a5: $(A4_LONG_A5_PDF)

clean:
	rm -rf $(OUTPUT_DIR)

.PHONY: all clean build_a4 build_a5 build_a4_short_side_a5 build_a4_long_side_a5
