# run bibtex or biber, clean up .bbl files
$bibtex_use = 2;

# latexmk -pdf
$pdf_mode = 1;

# --shell-escape b/c of minted package
# xelatex b/c of font stuff
$pdflatex = "xelatex -interaction=errorstopmode -file-line-error --synctex=1 -shell-escape %O %S";

push @generated_exts, "bak", "bbl", "run.xml", "nav", "snm", "vrb", "synctex.*"
