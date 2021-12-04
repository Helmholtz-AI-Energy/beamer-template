main=slides.tex

# Default
all: $(main)
	latexmk $<

# Build, watch, rebuild and open target in PDF viewer.
preview: $(main)
	latexmk -pvc $<


# Cleanup
clean: _restclean
	latexmk -c

allclean: _restclean
	latexmk -C

# Seems like latexmk's "push @generated_exts" doesn't treat directories.
_restclean:
	rm -rf _minted-*
