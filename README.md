## Helmholtz AI beamer template

Status
------

[![license: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

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

Building the slides
-------------------

In order to build your slides you can use your favorite LaTeX IDE, like TeXstudio, Texmaker or even Overleaf. Please ensure that you compile it with XeLaTeX or LuaLaTeX instead of the (usual default) pdfLaTeX.

Moreover, you can also use the provided Makefile and simply typing the following in your terminal.

``` bash
make
```

To get rid of all the temporary files, including the final slides PDF, created during the compilation you may also type:

``` bash
make clean
```

License
-------

The Helmholtz AI beamer template is distributed under the MIT license, see our [LICENSE](LICENSE) file for details.

Copyrights
----------

The images and fonts provided as part of this LaTeX source code repository are copyrighted. As member of the Helmholtz Association you can freely use the material. For Helmholtz AI external users, you have to ensure that you are allowed to use a) the Helmholtz AI visual material, b) the Helmholtz coporate design as well as c) the Hermann Bold font and Corporate-S font family.

