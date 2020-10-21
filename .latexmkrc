# Set latexmk to call lualatex instead of pdflatex for compiling Feynman diags
$pdflatex = "xelatex -interaction=nonstopmode -file-line-error --synctex=1 -shell-escape %O %S";

# Need to turn of ps and dvi generation for lualatex/xelatex, if you want these you'll 
# need to convert the pdf later.
$pdf_mode = 1;
$postscript_mode = 0;
$dvi_mode = 0;

# Put all generated files into a build dir to keep things a bit cleaner
#$aux_dir = "./build";

# Increase max repeats of luatex/xelatex runs, mostly needed for glossaries
#$max_repeat = 9;

# Set extensions for cleanup when using -c option
push @generated_exts;
