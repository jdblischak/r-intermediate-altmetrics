---
layout: page
title: Intermediate programming with R
subtitle: Subsetting with dplyr
minutes: 30
---



> ## Learning Objectives {.objectives}
>
> *  Subset rows using `filter` or `slice`
> *  Subset columns using `select`



In a previous lesson, we reviewed how to subset vectors and data frames in R.
Now we wil learn how to perform similar operations on data frames using functions from the dplyr package.
A short-term advantage of these functions is that they are faster to type, which facilitates interactive, exploratory analysis.
However, the true advantage of learning these subsetting functions is to combine them with dplyr's more powerful capabilities.

First we need to load the package.


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

To subset the rows, we use the function `filter`.
Thus to only include the research articles, we can run the following:


~~~{.r}
research <- filter(counts_raw, articleType == "Research Article")
~~~

The first argument supplied to `filter` is the original data frame.
The second argument is the criteria for filtering: `articleType == "Research Article"`.
This is the general format for all dplyr functions: the first argument is always the data frame followed by the arguments specific to that function.
Also notice that we referred to the column name `articleType` without using quotation marks or indexing the data frame, i.e. `counts_raw$articleType`.
This is a convenience feature available for all dplyr functions.

> ## Non-standard evaluation {.callout}
> The functions in dplyr allow you to refer directly to column names using what is called non-standard evaluation.
> The function `subset` from base R uses a similar trick to reduce typing.
> Using non-standard evaluation is extremely convenient for interactive programming but introduces many complications when writing functions.
> See the chapter in [Advanced R](http://adv-r.had.co.nz/Computing-on-the-language.html) by Hadley Wickham to learn about this topic in general
> or the [dplyr documentation](https://cran.r-project.org/web/packages/dplyr/vignettes/nse.html) to learn how it specifically applies to dplyr.

To include additional filters, we simply list them


~~~{.r}
research <- filter(counts_raw, articleType == "Research Article", journal == "pone")
~~~


> ##  {.challenge}
>
