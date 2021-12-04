## Helmholtz AI beamer template

Status
------

[![license: BSD-3](https://img.shields.io/badge/License-BSD3-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)

Requirements
------------

Ensure that you have an up-to-date LaTeX distribution installed on your system.

*Ubuntu/Debian*

``` bash
sudo apt-get install texlive-full
```

*Fedora/CentOS/RHEL*

``` bash
sudo dnf install texlive-scheme-full
```

*TeX Live (any system)*

If you don't have sudo access you can install [TeX Live](https://www.tug.org/texlive/) locally.
Visit the [TeX Live quick install page](https://www.tug.org/texlive/quickinstall.html) for instructions.

Building the slides
-------------------

In order to build your slides you can use your favorite LaTeX IDE, like TeXstudio, Texmaker or even Overleaf.
Please ensure that you compile it with XeLaTeX or LuaLaTeX instead of the (usual default) pdfLaTeX.

You can opt to use the provided Makefile and simply typing the following in your terminal:

``` bash
make
```

To get rid of all the temporary files, including the final slides PDF, created during the compilation you may also type:

``` bash
make clean
```

Alternatively, you can use the `latexmk` tool to compile your slides (either in the terminal or by setting it as the compiler in your IDE).
A working `.latexmkrc` is included, simply run the following:

```bash
latexmk slides.tex
```

To get rid of all temporary files created during compilation use the `-c` flag (`-C` to also remove the final slides PDF):

```bash
latexmk -c slides.tex
```

Note: At the time of writing, the contents of this repo can be readily used on [overleaf](https://overleaf.com).

License
-------

The Helmholtz AI beamer template is distributed under the BSD-3 license, see our [LICENSE](LICENSE) file for details.

Copyrights
----------

The images and fonts provided as part of this LaTeX source code repository are copyrighted. As member of the Helmholtz Association you can freely use the material. For Helmholtz AI external users, you have to ensure that you are allowed to use a) the Helmholtz AI visual material, b) the Helmholtz coporate design as well as c) the Hermann Bold font and Corporate-S font family.

