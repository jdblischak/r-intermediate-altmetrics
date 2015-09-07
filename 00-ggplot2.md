---
layout: page
title: Intermediate programming with R
subtitle: ggplot2
minutes: 10
---

> ## Learning Objectives {.objectives}
>



```r
library("dplyr")
```

```
## 
## Attaching package: 'dplyr'
## 
## The following objects are masked from 'package:stats':
## 
##     filter, lag
## 
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
```

```r
library("ggplot2")
```

```
## Loading required package: methods
```


```r
counts_norm <- read.delim("data/counts-norm.txt.gz", stringsAsFactors = FALSE)
```


Do papers with more authors get more citations?


```r
ggplot(counts_norm, aes(x = authorsCount, y = wosCountThru2011)) +
  geom_point()
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3-1.png) 

Do papers with more authors get more social media buzz?


```r
ggplot(counts_norm, aes(x = authorsCount, y = backtweetsCount)) +
  geom_point()
```

```
## Warning: Removed 6614 rows containing missing values (geom_point).
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4-1.png) 


```r
ggplot(counts_norm, aes(x = authorsCount, y = facebookLikeCount)) +
  geom_point()
```

```
## Warning: Removed 11970 rows containing missing values (geom_point).
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-5-1.png) 

Relationship between Twitter and Facebook.


```r
ggplot(counts_norm, aes(x = backtweetsCount, y = facebookLikeCount)) +
  geom_point()
```

```
## Warning: Removed 13264 rows containing missing values (geom_point).
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6-1.png) 

Number of authors by journal.


```r
ggplot(counts_norm, aes(x = journal, y = authorsCount)) +
  geom_boxplot()
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-7-1.png) 

Effect of time on number of citations.


```r
ggplot(counts_norm, aes(x = daysSincePublished, y = wosCountThru2011)) +
  geom_point()
```

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-8-1.png) 

How do the experts do?


```r
ggplot(counts_norm, aes(x = f1000Factor, y = wosCountThru2011)) +
  geom_point()
```

```
## Warning: Removed 2805 rows containing missing values (geom_point).
```

![plot of chunk unnamed-chunk-9](figure/unnamed-chunk-9-1.png) 

Compared to the masses?


```r
ggplot(counts_norm, aes(x = backtweetsCount, y = wosCountThru2011)) +
  geom_point()
```

```
## Warning: Removed 6614 rows containing missing values (geom_point).
```

![plot of chunk unnamed-chunk-10](figure/unnamed-chunk-10-1.png) 

split by journal


```r
ggplot(counts_norm, aes(x = backtweetsCount, y = wosCountThru2011)) +
  geom_point() +
  facet_wrap(~journal)
```

```
## Warning: Removed 1325 rows containing missing values (geom_point).
```

```
## Warning: Removed 1068 rows containing missing values (geom_point).
```

```
## Warning: Removed 1299 rows containing missing values (geom_point).
```

```
## Warning: Removed 643 rows containing missing values (geom_point).
```

```
## Warning: Removed 621 rows containing missing values (geom_point).
```

```
## Warning: Removed 199 rows containing missing values (geom_point).
```

```
## Warning: Removed 1459 rows containing missing values (geom_point).
```

![plot of chunk unnamed-chunk-11](figure/unnamed-chunk-11-1.png) 

split by year


```r
ggplot(counts_norm, aes(x = backtweetsCount, y = wosCountThru2011)) +
  geom_point() +
  facet_wrap(~year)
```

```
## Warning: Removed 33 rows containing missing values (geom_point).
```

```
## Warning: Removed 187 rows containing missing values (geom_point).
```

```
## Warning: Removed 419 rows containing missing values (geom_point).
```

```
## Warning: Removed 873 rows containing missing values (geom_point).
```

```
## Warning: Removed 1011 rows containing missing values (geom_point).
```

```
## Warning: Removed 1287 rows containing missing values (geom_point).
```

```
## Warning: Removed 1637 rows containing missing values (geom_point).
```

```
## Warning: Removed 1167 rows containing missing values (geom_point).
```

![plot of chunk unnamed-chunk-12](figure/unnamed-chunk-12-1.png) 

Wikipedia and citation count


```r
ggplot(counts_norm, aes(x = wikipediaCites, y = wosCountThru2011)) +
  geom_point()
```

```
## Warning: Removed 5589 rows containing missing values (geom_point).
```

![plot of chunk unnamed-chunk-13](figure/unnamed-chunk-13-1.png) 

Wikipedia and Facebook


```r
ggplot(counts_norm, aes(x = wikipediaCites, y = facebookLikeCount)) +
  geom_point()
```

```
## Warning: Removed 13804 rows containing missing values (geom_point).
```

![plot of chunk unnamed-chunk-14](figure/unnamed-chunk-14-1.png) 

Downloads and citation counts.


```r
ggplot(counts_norm, aes(x = pdfDownloadsCount, y = wosCountThru2011)) +
  geom_point()
```

![plot of chunk unnamed-chunk-15](figure/unnamed-chunk-15-1.png) 

Downloads and mendeleyReadersCount


```r
ggplot(counts_norm, aes(x = pdfDownloadsCount, y = mendeleyReadersCount)) +
  geom_point()
```

```
## Warning: Removed 5 rows containing missing values (geom_point).
```

![plot of chunk unnamed-chunk-16](figure/unnamed-chunk-16-1.png) 

HTML page view versus PDF downloads


```r
ggplot(counts_norm, aes(x = htmlDownloadsCount, y = pdfDownloadsCount)) +
  geom_point() +
  facet_wrap(~journal)
```

![plot of chunk unnamed-chunk-17](figure/unnamed-chunk-17-1.png) 


```r
counts_norm <- mutate(counts_norm, immuno = grepl("Immunology", plosSubjectTags))
```


```r
ggplot(counts_norm, aes(x = htmlDownloadsCount, y = pdfDownloadsCount,
                        color = immuno)) +
  geom_point() +
  facet_wrap(~journal)
```

![plot of chunk unnamed-chunk-19](figure/unnamed-chunk-19-1.png) 

Where are immuno papers published?


```r
ggplot(counts_norm, aes(x = journal, fill = immuno)) +
  geom_bar()
```

![plot of chunk unnamed-chunk-20](figure/unnamed-chunk-20-1.png) 

Evolutionary biology papers?


```r
counts_norm <- mutate(counts_norm, evo = grepl("Evolutionary Biology", plosSubjectTags))
```


```r
ggplot(counts_norm, aes(x = journal, fill = evo)) +
  geom_bar()
```

![plot of chunk unnamed-chunk-22](figure/unnamed-chunk-22-1.png) 
