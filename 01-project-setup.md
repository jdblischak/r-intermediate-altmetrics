---
layout: page
title: Intermediate programming with R
subtitle: Setting up a project
minutes: 10
---

> ## Learning Objectives {.objectives}
>
> * Create directories and files
> * Understand the difference between absolute and relative paths

Before we start using R, we will first review the basics of the Unix shell by setting up our project.
Open the terminal in OS X or Linux, or Git Bash in Windows.

Our project will explore the citations and alternative metrics (altmetrics) for articles published in the PLOS family of journals between 2003 and 2010.
The data set was compiled by Priem et
al. 2012 ([publication][priem2012], [code][priem2012code]).

[priem2012]: http://arxiv.org/abs/1203.4745
[priem2012code]: https://github.com/jasonpriem/plos_altmetrics_study

First create a new directory to store the project files called `altmetrics` and then change to that directory.

~~~ {.bash}
mkdir altmetrics
cd altmetrics
~~~

Repeat this process to create a subdirectory to store the data files.

~~~{.bash}
mkdir data
cd data
~~~

> ## Finding your location {.callout}
> Recall that you can always determine where you are by running the command `pwd`, which stands for "print working directory".
> Also, if you run `cd` with no arguments, it takes you to your home directory.

Download the two data files using `wget`.

~~~{.bash}
wget https://raw.githubusercontent.com/jdblischak/r-intermediate-altmetrics/gh-pages/data/counts-raw.txt.gz
wget https://raw.githubusercontent.com/jdblischak/r-intermediate-altmetrics/gh-pages/data/counts-norm.txt.gz
~~~

The first file, `counts-raw.txt.gz`, contains the raw counts for each of the articles across all the metrics.
The second file, `counts-norm.txt.gz`, contains the counts for each of the articles across all the metrics after they have been normalized across disciplines and years.

Confirm that the files downloaded by listing the files in `data`.

~~~{.bash}
ls
~~~
~~~ {.output}
counts-norm.txt.gz counts-raw.txt.gz
~~~

Now move back up a directory to `altmetrics`.
One option would be to specify the absolute path to this directory, e.g. `~/altmetrics/` if you created the directory in your home folder.
However, an easier option is to use a relative path, which is dependent on the directory you are currently in.
The shortcut to move to the directory above is two periods: `..`.

~~~{.bash}
cd ..
~~~

Now you should be in the `altmetrics` directory.
If you ran the above command again, you would be moved to the directory where you created `altmetrics`.

To create files, we'll use the simple text editor `nano`.
As an argument, you provide the name of an existing file to edit or the name of a new file to create.
If you call `nano` without specifying a filename, it will prompt you for a filename when saving.
Create a file to practice.

~~~{.bash}
nano example-file
~~~

The commands are listed at the bottom of the screen.
The `^` stands for `Ctrl`,
thus to save type `Ctrl-W` and to exit type `Ctrl-X`.

Remove the file with `rm`.

~~~{.bash}
rm example-file
~~~

> ## Organizing a larger project {.callout}
>
> Projects can grow quickly.
> For ideas on organizing your own projects, see [A Quick Guide to Organizing Computational Biology Projects][noble2009] by William Noble.

[noble2009]: http://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1000424

> ## Create a README file {.challenge}
>
> It is a convention to have a file named `README` in a project directory to explain what it contains (both for others and your future self).
> Use `nano` to create a README file.
> Include the date and explain that this directory was created for a Software Carpentry workshop.
