# The idea is to convert every Markdown file here into a HTML presentation using reveal.js

SOURCE_DOCS := $(wildcard *.md)

EXPORTED_DOCS=\
  $(addprefix public/,$(SOURCE_DOCS:.md=.html))

RM=/bin/rm

PANDOC=pandoc

PANDOC_OPTIONS=-t revealjs -s \
	-V revealjs-url=. \
	--include-in-header=slides.css \
	-V hlss=zenburn \
	-V theme=sky \
	-V transition=fade  \
	-i 
# --embed-resources   # This make a single file, good for distribution
#	-A footer.html # The footer is just too big

# Show all list items immediately in this presentation only.
public/01-access-machines.html: PANDOC_OPTIONS := $(filter-out -i,$(PANDOC_OPTIONS))

public/%.html : %.md *.css
	$(PANDOC) $(PANDOC_OPTIONS) -o $@ $<

.PHONY: all clean

all : $(EXPORTED_DOCS)

clean:
	- $(RM) $(EXPORTED_DOCS)
