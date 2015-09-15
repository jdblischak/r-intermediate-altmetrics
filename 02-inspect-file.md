---
layout: page
title: Intermediate programming with R
subtitle: Inspecting a file
minutes: 20
---

> ## Learning Objectives {.objectives}
>
> * Inspect a file from the command line
> * Chain Unix commands using pipes
> * Search with `grep`
> * Redirect output to a new file

Now let's explore the data files we have downloaded.
Inspecting data files with the Unix shell is a quick and easy way to learn about a data set before attempting to import it with R.

Switch to the `data` directory.

~~~ {.bash}
cd data
ls
~~~
~~~ {.output}
counts-norm.txt.gz counts-raw.txt.gz
~~~

Inspect the first line of the raw counts file.

~~~ {.bash}
head -n 1 counts-raw.txt.gz
~~~
~~~ {.output}
��LOdf_all.txt�\�v��v#_��I���}�~x�E=l�ƴ�D��d�%W ��Cj����|��a������#�%٧
~~~

> ## Tab completion {.callout}
>
> Recall that you can save typing by pressing the Tab character to auto-complete the names of directories and files.

It wasn't very informative because the file is compressed to save space.
You could de-compress it with `gunzip`, but instead use `gunzip -c` to send the decompressed data to standard out.
This allows us to view the contents of the file while still saving disk space.
Pass standard out to the `head` function using the "pipe" command (it's the vertical bar on your keyboard).

~~~ {.bash}
gunzip -c counts-raw.txt.gz | head -n 1
~~~
~~~ {.output}
"doi"  "pubDate"	"journal"	"title"	"articleType"	"authorsCount"	"f1000Factor"	"backtweetsCount"	"deliciousCount"	"pmid"	"plosSubjectTags"	"plosSubSubjectTags"	"facebookShareCount"	"facebookLikeCount"	"facebookCommentCount"	"facebookClickCount"	"mendeleyReadersCount"	"almBlogsCount"	"pdfDownloadsCount"	"xmlDownloadsCount"	"htmlDownloadsCount"	"almCiteULikeCount"	"almScopusCount"	"almPubMedCentralCount"	"almCrossRefCount"	"plosCommentCount"	"plosCommentResponsesCount"	"wikipediaCites"	"year"	"daysSincePublished"	"wosCountThru2010"	"wosCountThru2011"
~~~

> ## Decompression with zcat {.callout}
>
> Some systems provide a shortcut for `gunzip -c`: the function `zcat`.
> Because it is shorter and provides the exact same functionality, we recommend using `zcat` if it is available.
> Notably Git Bash for Windows users does not provide `zcat`, so we use `gunzip -c` here.

Now that worked as expected.
From this header line, we observe that some columns contain descriptions of the publication, e.g. "journal" and "title", and others contain the counts for the various metrics, e.g. "wosCountThru2011" is the number of citations the paper received thru 2011 according to Thomson Reuters' Web of Science.

Now check the number of articles in each of the files using `wc`.

~~~ {.bash}
gunzip -c counts-raw.txt.gz | wc -l
~~~
~~~ {.output}
24332
~~~

~~~ {.bash}
gunzip -c counts-norm.txt.gz | wc -l
~~~
~~~ {.output}
21097
~~~

The normalized file contains data on fewer publications.
According to their publication, they focus only on articles that are labeled "Research Articles".
Confirm that this is the reason for the difference between the two files by inspecting the 5th column, "articleType".
You can select specific columns (aka fields) using `cut`.

~~~ {.bash}
gunzip -c counts-raw.txt.gz | cut -f5 | head
~~~
~~~ {.output}
"articleType"
"Research Article"
"Research Article"
"Synopsis"
"Synopsis"
"Research Article"
"Research Article"
"Synopsis"
"Feature"
"Community Page"
~~~

You can count the number of occurrences of each "articleType" using the function `uniq` and passing it the `-c` flag.
However, `uniq` requires that the data is pre-sorted to work properly.
Thus pipe the data through the command `sort` before passing it to `uniq`.

~~~ {.bash}
gunzip -c counts-raw.txt.gz | cut -f5 | sort | uniq -c | head
~~~
~~~ {.output}
      1 "articleType"
      5 "Best Practice"
     57 "Book Review/Science in the Media"
     10 "Case Report"
      1 "Clinical Trial"
     56 "Community Page"
    172 "Correction"
    283 "Correspondence"
     13 "Correspondence and Other Communications"
    189 "Editorial"
~~~

We can see that the raw counts file contains many different types of articles.

Perform the same operation on the normalized counts file.

~~~ {.bash}
gunzip -c counts-norm.txt.gz | cut -f5 | sort | uniq -c
~~~
~~~ {.output}
      1 "articleType"
  21096 "Research Article"
~~~

And indeed that is the difference.
The normalized counts file only contains data on research articles.

Let's keep exploring.
What is the maximum number of citations for a single paper in this data set?
Use the data from 2011 in column 32.

~~~ {.bash}
gunzip -c counts-raw.txt.gz | cut -f32 | sort -n | tail -n 1
~~~
~~~ {.output}
737
~~~

The `-n` passed to sort is critical because it specifies the data is numeric.
By default `sort` performs alphabetical sorting, in which case 9 would be greater than 100.

The 11th columns contains the PLOS subject tags.
How many articles have the subject tag "Evolutionary Biology"?
Use `grep` to search for the term.

~~~ {.bash}
gunzip -c counts-raw.txt.gz | cut -f11 | grep "Evolutionary Biology" | wc -l
~~~
~~~ {.output}
2864
~~~

How many articles have the subject tag "Evolutionary Biology" and "Cell Biology"?

~~~ {.bash}
gunzip -c counts-raw.txt.gz | cut -f11 | grep "Evolutionary Biology" | grep "Cell Biology" | wc -l
~~~
~~~ {.output}
153
~~~

Instead of simply counting the files that match the search criteria, save them to a new file.
This is done with the redirection operator, `>`.

~~~ {.bash}
zcat counts-raw.txt.gz | cut -f11 | grep "Evolutionary Biology" | grep "Cell Biology" > evo-cell-bio.txt
~~~

~~~ {.bash}
wc -l evo-cell-bio.txt
~~~
~~~ {.output}
170
~~~

What could be the reason for the discrepancy in the number of articles in our saved file?

> ## Largest number of Wikipedia cites {.challenge}
>
> What is the largest number of Wikipedia cites that an article in this data set has received?
> Hint: The counts of Wikipedia cites are in column 28.

> ## Find articles in your field {.challenge}
>
> Choose two PLOS subject tags to search for and save these articles to a new file.
> How many articles are there?
