---
layout: page
title: Intermediate programming with R
subtitle: ggplot2
minutes: 10
---



> ## Learning Objectives {.objectives}
>



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



~~~{.r}
library("ggplot2")
~~~



~~~{.output}
Loading required package: methods

~~~


~~~{.r}
counts_norm <- read.delim("data/counts-norm.txt.gz", stringsAsFactors = FALSE)
~~~


Do papers with more authors get more citations?


~~~{.r}
ggplot(counts_norm, aes(x = authorsCount, y = wosCountThru2011)) +
  geom_point()
~~~

<img src="fig/04-import-data-unnamed-chunk-4-1.png" title="plot of chunk unnamed-chunk-4" alt="plot of chunk unnamed-chunk-4" style="display: block; margin: auto;" />

Do papers with more authors get more social media buzz?


~~~{.r}
ggplot(counts_norm, aes(x = authorsCount, y = backtweetsCount)) +
  geom_point()
~~~



~~~{.output}
Warning: Removed 6614 rows containing missing values (geom_point).

~~~

<img src="fig/04-import-data-unnamed-chunk-5-1.png" title="plot of chunk unnamed-chunk-5" alt="plot of chunk unnamed-chunk-5" style="display: block; margin: auto;" />


~~~{.r}
ggplot(counts_norm, aes(x = authorsCount, y = facebookLikeCount)) +
  geom_point()
~~~



~~~{.output}
Warning: Removed 11970 rows containing missing values (geom_point).

~~~

<img src="fig/04-import-data-unnamed-chunk-6-1.png" title="plot of chunk unnamed-chunk-6" alt="plot of chunk unnamed-chunk-6" style="display: block; margin: auto;" />

Relationship between Twitter and Facebook.


~~~{.r}
ggplot(counts_norm, aes(x = backtweetsCount, y = facebookLikeCount)) +
  geom_point()
~~~



~~~{.output}
Warning: Removed 13264 rows containing missing values (geom_point).

~~~

<img src="fig/04-import-data-unnamed-chunk-7-1.png" title="plot of chunk unnamed-chunk-7" alt="plot of chunk unnamed-chunk-7" style="display: block; margin: auto;" />

Number of authors by journal.


~~~{.r}
ggplot(counts_norm, aes(x = journal, y = authorsCount)) +
  geom_boxplot()
~~~

<img src="fig/04-import-data-unnamed-chunk-8-1.png" title="plot of chunk unnamed-chunk-8" alt="plot of chunk unnamed-chunk-8" style="display: block; margin: auto;" />

Effect of time on number of citations.


~~~{.r}
ggplot(counts_norm, aes(x = daysSincePublished, y = wosCountThru2011)) +
  geom_point()
~~~

<img src="fig/04-import-data-unnamed-chunk-9-1.png" title="plot of chunk unnamed-chunk-9" alt="plot of chunk unnamed-chunk-9" style="display: block; margin: auto;" />

How do the experts do?


~~~{.r}
ggplot(counts_norm, aes(x = f1000Factor, y = wosCountThru2011)) +
  geom_point()
~~~



~~~{.output}
Warning: Removed 2805 rows containing missing values (geom_point).

~~~

<img src="fig/04-import-data-unnamed-chunk-10-1.png" title="plot of chunk unnamed-chunk-10" alt="plot of chunk unnamed-chunk-10" style="display: block; margin: auto;" />

Compared to the masses?


~~~{.r}
ggplot(counts_norm, aes(x = backtweetsCount, y = wosCountThru2011)) +
  geom_point()
~~~



~~~{.output}
Warning: Removed 6614 rows containing missing values (geom_point).

~~~

<img src="fig/04-import-data-unnamed-chunk-11-1.png" title="plot of chunk unnamed-chunk-11" alt="plot of chunk unnamed-chunk-11" style="display: block; margin: auto;" />

split by journal


~~~{.r}
ggplot(counts_norm, aes(x = backtweetsCount, y = wosCountThru2011)) +
  geom_point() +
  facet_wrap(~journal)
~~~



~~~{.output}
Warning: Removed 1325 rows containing missing values (geom_point).

~~~



~~~{.output}
Warning: Removed 1068 rows containing missing values (geom_point).

~~~



~~~{.output}
Warning: Removed 1299 rows containing missing values (geom_point).

~~~



~~~{.output}
Warning: Removed 643 rows containing missing values (geom_point).

~~~



~~~{.output}
Warning: Removed 621 rows containing missing values (geom_point).

~~~



~~~{.output}
Warning: Removed 199 rows containing missing values (geom_point).

~~~



~~~{.output}
Warning: Removed 1459 rows containing missing values (geom_point).

~~~

<img src="fig/04-import-data-unnamed-chunk-12-1.png" title="plot of chunk unnamed-chunk-12" alt="plot of chunk unnamed-chunk-12" style="display: block; margin: auto;" />

split by year


~~~{.r}
ggplot(counts_norm, aes(x = backtweetsCount, y = wosCountThru2011)) +
  geom_point() +
  facet_wrap(~year)
~~~



~~~{.output}
Warning: Removed 33 rows containing missing values (geom_point).

~~~



~~~{.output}
Warning: Removed 187 rows containing missing values (geom_point).

~~~



~~~{.output}
Warning: Removed 419 rows containing missing values (geom_point).

~~~



~~~{.output}
Warning: Removed 873 rows containing missing values (geom_point).

~~~



~~~{.output}
Warning: Removed 1011 rows containing missing values (geom_point).

~~~



~~~{.output}
Warning: Removed 1287 rows containing missing values (geom_point).

~~~



~~~{.output}
Warning: Removed 1637 rows containing missing values (geom_point).

~~~



~~~{.output}
Warning: Removed 1167 rows containing missing values (geom_point).

~~~

<img src="fig/04-import-data-unnamed-chunk-13-1.png" title="plot of chunk unnamed-chunk-13" alt="plot of chunk unnamed-chunk-13" style="display: block; margin: auto;" />

Wikipedia and citation count


~~~{.r}
ggplot(counts_norm, aes(x = wikipediaCites, y = wosCountThru2011)) +
  geom_point()
~~~



~~~{.output}
Warning: Removed 5589 rows containing missing values (geom_point).

~~~

<img src="fig/04-import-data-unnamed-chunk-14-1.png" title="plot of chunk unnamed-chunk-14" alt="plot of chunk unnamed-chunk-14" style="display: block; margin: auto;" />

Wikipedia and Facebook


~~~{.r}
ggplot(counts_norm, aes(x = wikipediaCites, y = facebookLikeCount)) +
  geom_point()
~~~



~~~{.output}
Warning: Removed 13804 rows containing missing values (geom_point).

~~~

<img src="fig/04-import-data-unnamed-chunk-15-1.png" title="plot of chunk unnamed-chunk-15" alt="plot of chunk unnamed-chunk-15" style="display: block; margin: auto;" />

Downloads and citation counts.


~~~{.r}
ggplot(counts_norm, aes(x = pdfDownloadsCount, y = wosCountThru2011)) +
  geom_point()
~~~

<img src="fig/04-import-data-unnamed-chunk-16-1.png" title="plot of chunk unnamed-chunk-16" alt="plot of chunk unnamed-chunk-16" style="display: block; margin: auto;" />

Downloads and mendeleyReadersCount


~~~{.r}
ggplot(counts_norm, aes(x = pdfDownloadsCount, y = mendeleyReadersCount)) +
  geom_point()
~~~



~~~{.output}
Warning: Removed 5 rows containing missing values (geom_point).

~~~

<img src="fig/04-import-data-unnamed-chunk-17-1.png" title="plot of chunk unnamed-chunk-17" alt="plot of chunk unnamed-chunk-17" style="display: block; margin: auto;" />

HTML page view versus PDF downloads


~~~{.r}
ggplot(counts_norm, aes(x = htmlDownloadsCount, y = pdfDownloadsCount)) +
  geom_point() +
  facet_wrap(~journal)
~~~

<img src="fig/04-import-data-unnamed-chunk-18-1.png" title="plot of chunk unnamed-chunk-18" alt="plot of chunk unnamed-chunk-18" style="display: block; margin: auto;" />


~~~{.r}
counts_norm <- mutate(counts_norm, immuno = grepl("Immunology", plosSubjectTags))
~~~


~~~{.r}
ggplot(counts_norm, aes(x = htmlDownloadsCount, y = pdfDownloadsCount,
                        color = immuno)) +
  geom_point() +
  facet_wrap(~journal)
~~~

<img src="fig/04-import-data-unnamed-chunk-20-1.png" title="plot of chunk unnamed-chunk-20" alt="plot of chunk unnamed-chunk-20" style="display: block; margin: auto;" />

Where are immuno papers published?


~~~{.r}
ggplot(counts_norm, aes(x = journal, fill = immuno)) +
  geom_bar()
~~~

<img src="fig/04-import-data-unnamed-chunk-21-1.png" title="plot of chunk unnamed-chunk-21" alt="plot of chunk unnamed-chunk-21" style="display: block; margin: auto;" />

Evolutionary biology papers?


~~~{.r}
counts_norm <- mutate(counts_norm, evo = grepl("Evolutionary Biology", plosSubjectTags))
~~~


~~~{.r}
ggplot(counts_norm, aes(x = journal, fill = evo)) +
  geom_bar()
~~~

<img src="fig/04-import-data-unnamed-chunk-23-1.png" title="plot of chunk unnamed-chunk-23" alt="plot of chunk unnamed-chunk-23" style="display: block; margin: auto;" />
