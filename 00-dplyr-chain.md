---
layout: page
title: Intermediate programming with R
subtitle: Chaining commands with dplyr
minutes: 30
---



> ## Learning Objectives {.objectives}
>
> *  Chain commands together using `%>%`
> *  Sort rows using `arrange`




~~~{.r}
library("dplyr")
~~~



~~~{.output}

Attaching package: 'dplyr'

The following objects are masked from 'package:stats':

    filter, lag

The following objects are masked from 'package:base':

    intersect, setdiff, setequal, union

~~~


~~~ {.bash}
zcat counts-raw.txt.gz | head -n 1
~~~


~~~{.r}
counts_raw %>% head(n = 1)
~~~



~~~{.output}
                           doi    pubDate journal
1 10.1371/journal.pbio.0000001 2003-10-13    pbio
                                                                        title
1 A Functional Analysis of the Spacer of V(D)J Recombination Signal Sequences
       articleType authorsCount f1000Factor backtweetsCount deliciousCount
1 Research Article            6           6               0              0
      pmid                           plosSubjectTags plosSubSubjectTags
1 14551903 Cell Biology|Immunology|Molecular Biology                   
  facebookShareCount facebookLikeCount facebookCommentCount
1                  0                 0                    0
  facebookClickCount mendeleyReadersCount almBlogsCount pdfDownloadsCount
1                  0                    4             0               348
  xmlDownloadsCount htmlDownloadsCount almCiteULikeCount almScopusCount
1                71               6131                 0             28
  almPubMedCentralCount almCrossRefCount plosCommentCount
1                     7                5                0
  plosCommentResponsesCount wikipediaCites year daysSincePublished
1                         0              0 2003               2628
  wosCountThru2010 wosCountThru2011
1               29               33

~~~

~~~ {.bash}
zcat counts-raw.txt.gz | wc -l
~~~


~~~{.r}
counts_raw %>% nrow
~~~



~~~{.output}
[1] 24331

~~~

~~~ {.bash}
zcat counts-raw.txt.gz | cut -f5 | head
~~~


~~~{.r}
counts_raw %>% select(5) %>% head
~~~



~~~{.output}
       articleType
1 Research Article
2 Research Article
3         Synopsis
4         Synopsis
5 Research Article
6 Research Article

~~~


~~~{.r}
counts_raw %>% select(articleType) %>% head
~~~



~~~{.output}
       articleType
1 Research Article
2 Research Article
3         Synopsis
4         Synopsis
5 Research Article
6 Research Article

~~~

~~~ {.bash}
zcat counts-raw.txt.gz | cut -f5 | sort | uniq -c | head
~~~

Not exactly the same because haven't done grouping.


~~~{.r}
counts_raw %>% select(articleType) %>% arrange(articleType) %>% distinct %>% nrow
~~~



~~~{.output}
[1] 48

~~~

~~~ {.bash}
zcat counts-raw.txt.gz | cut -f32 | sort -n | tail -n 1
~~~


~~~{.r}
counts_raw %>% select(32) %>% tail(n = 1)
~~~



~~~{.output}
      wosCountThru2011
24331                6

~~~


~~~{.r}
counts_raw %>% select(wosCountThru2011) %>% arrange(wosCountThru2011) %>% tail(n = 1)
~~~



~~~{.output}
      wosCountThru2011
24331              737

~~~


~~~{.r}
counts_raw %>% arrange(wosCountThru2011) %>% tail(n = 1) %>% select(title)
~~~



~~~{.output}
                                                 title
24331 Relaxed Phylogenetics and Dating with Confidence

~~~


~~~{.r}
counts_raw %>% arrange(wosCountThru2011) %>% tail(n = 1) %>% select(doi:authorsCount)
~~~



~~~{.output}
                               doi    pubDate journal
24331 10.1371/journal.pbio.0040088 2006-03-14    pbio
                                                 title      articleType
24331 Relaxed Phylogenetics and Dating with Confidence Research Article
      authorsCount
24331            4

~~~

~~~ {.bash}
zcat counts-raw.txt.gz | cut -f11 | grep "Evolutionary Biology" | wc -l
~~~


~~~{.r}
counts_raw %>% filter(grepl("Evolutionary Biology", plosSubjectTags)) %>% nrow
~~~



~~~{.output}
[1] 2864

~~~

~~~ {.bash}
zcat counts-raw.txt.gz | cut -f11 | grep "Evolutionary Biology" | grep "Cell Biology" | wc -l
~~~


~~~{.r}
counts_raw %>% filter(grepl("Evolutionary Biology", plosSubjectTags),
                      grepl("Cell Biology", plosSubjectTags)) %>% nrow
~~~



~~~{.output}
[1] 153

~~~

~~~ {.bash}
zcat counts-raw.txt.gz | grep "Evolutionary Biology" | grep "Cell Biology" > evo-cell-bio.txt
~~~


~~~{.r}
evo_cell_bio <- counts_raw %>% filter(grepl("Evolutionary Biology", plosSubjectTags),
                                      grepl("Cell Biology", plosSubjectTags))
~~~


> ## {.callout}
> 

> ##  {.challenge}
>
