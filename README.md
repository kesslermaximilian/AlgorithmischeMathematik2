[![Build Status](https://api.travis-ci.com/kesslermaximilian/AlgorithmischeMathematik2.svg)](https://travis-ci.com/kesslermaximilian/AlgorithmischeMathematik2)

# Geometrie und Topologie

These are my lecture notes for the 'Einführung in die Geometrie und Topologie', taught by [Daniel Kasprowski](http://www.math.uni-bonn.de/people/daniel/) in the summer term 2021 at the University of Bonn. There is no guarantee for completeness or correctness.

- The homepage of the course can also be found [here](https://wt.iam.uni-bonn.de/ferrari/teaching/lectures-homepages/almaiiss19-1)
- The [most recent version](https://kesslermaximilian.github.io/AlgorithmischeMathematik2/2021_Algorithmische_Mathematik.pdf) of this script is made available with [Travis CI](https://github.com/traviscibot). You can also have a look at the [generated log files](https://kesslermaximilian.github.io/AlgorithmischeMathematik2/2021_Algorithmische_Mathematik.log)

## Set-up
This document uses custom packages, so you you won't be directly able to compile this document. They are available as my [Latex Packages](https://github.com/kesslermaximilian/LatexPackages) repository and added as a submodule to this repository. You will have to clone them as well and tell TeX where to find these before compiling. Follow these steps:

### For the quick:
- Clone the repository with   
```git clone https://github.com/kesslermaximilian/AlgorithmischeMathematik2.git```   
- Enter it with `cd AlgorithmischeMathematik2`
- Run `make init`. This gets the submodule, sets up githooks and gets the generated gnuplot files, don't worry about it too much
- Run `make config`. This sets some local git configuration for the repository which I recommend.
- To build the document, run `make full` or even just `make`. This will build the document now
- You can now edit the source files, `full.tex` and the included files found in `inputs/`. To compile, just run `make` again.

Further explanation on what all of this does can be found in the following sections

### Setting up repository
After having cloned the repository, we still have to:
 
- Get the submodule `LatexPackages`. This is what `make init-submodule` does via the `git submodule update --init --rebase` command.
- Set up some git hooks for the `gitinfo2` package. These tell `git` to write some metadata that `TeX` can read in later. `make init-git-hooks` sets this up correctly and runs these a first time.

`make init` combines the above two commands so that your repository is ready to use

### Configuring git
I recommand to configure
- `git config push.recurseSubmodules check`. This prevents you from pushing changes in this repository without also pushing changes in the submodule, as this would leave others unable to obtain your repository state
- `git config status.submodulesummary 1`. This adds a summary of the submodule to the `git status` command.
- `git config push.followTags true`. This pushes annotated `git tag`s that are reachable to origin automatically.

`make config` sets these configs for you.

#### SSH issues
If you are usually accessing git using `ssh`, it is possible that you have trouble cloning the submodule, as this is added over `https`. You will have to clone the usual repository first and then edit the `.submodules` file `git` provides and change the url of the submodule to the `ssh` version manually. Then run `gut submodule update` with above arguments. This should clone the submodule via `ssh` now.

### Tell TeX  where to find the packages
Now that we obtained all neccessary resources and configured git correctly, we are ready to compile the document. For this, we have to tell TeX where to find the packages we obtained as a submodule.   
By default, TeX will try to search for packages in your source folder, your tex installation folder (e.g. TeXLive) or your custom TeX folder (typically `~/texmf/tex/latex`).
- We use the `TEXINPUTS` environment variable to achieve this, so before manual compiling just enter   
```export TEXINPUTS=LatexPackages//:```   
in your shell.
- TeX will now look in this directory (relative to the source file) for packages and properly find the custom packages. Note that this only holds for the current shell, you will have to enter this for each new shell you start.
- To simplify, there is a shell script `export_texinputs.sh` that will execute exactly this. To call it, use `source ./export_texinputs.sh` so that the export command is executed in your current shell and not in a newly-created subshell. This is e.g. useful if you start an editor from your shell that needs to find the packages.

For further simplification, the `Makefile` handles this exporting for you and provides several compilation commands:

- `make full-pdflatex`. This just runs a plain `pdflatex` on the full document - with correctly set `TEXINPUTS` variable
- `make full`. This runs `latexmk` on your main document, which takes care of `biber` for the bibliography and compiles a sufficient number of times for all references to work

For further make directives regarding `gnuplots`, see the corresponding section.


### Why two files?
You may have noticed that there is also the `master.tex` file. This is very similar to the `full.tex` and includes the same resources. I use this as a lightweight version for write-up, and don't include all lectures / the appendix etc to increase compilation speed.   
All commands that the `Makefile` provides have a `master` version (just replace `full` with `master`) as well that are then run on this document.

### Figures
I use a combination of 

- hand-drawn figures, if i did not have time to make a proper one yet (or no motivation)
- inkscape figures in ```.pdf_tex``` format, the source files are in the ```figures``` directory
- external figures copied from elsewhere, also found in ```figures```. You can find the source in the document in this case
- TikZ figures
