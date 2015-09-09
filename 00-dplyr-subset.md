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

Subsetting alone is not the most exciting task, but it provides a gentle introduction to the dplyr approach.
We'll use subsetting to explore the data and learn about the general trends and to identify outliers.
And we'll explore these ideas further as we learn more dplyr functions.

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

Let's start by limiting our analysis to only include research articles.
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

How many research articles were published in PLOS journals in 2006?


~~~{.r}
research_2006 <- filter(research, year == 2006)
nrow(research_2006)
~~~



~~~{.output}
[1] 873

~~~

And how many of the these articles from 2006 were mentioned in at least one tweet?


~~~{.r}
research_2006_tweet <- filter(research_2006, backtweetsCount > 0)
nrow(research_2006_tweet)
~~~



~~~{.output}
[1] 10

~~~

And we aren't limited to one filtering condition at a time.
We can list an arbitrary number of filtering conditions separated by commas.
For example, how many of these 2006 articles received at least one Facebook comment?


~~~{.r}
research_2006_fb <- filter(research, year == 2006, facebookCommentCount > 0)
nrow(research_2006_fb)
~~~



~~~{.output}
[1] 5

~~~

Furthermore, we can create even more complex filters using the `&` ("and") and `|` ("or") operators. How many of the articles in 2006 had at least one Tweet or Facebook comment?


~~~{.r}
research_2006_fb_tweet <- filter(research, year == 2006,
                                 facebookCommentCount > 0 | backtweetsCount > 0)
nrow(research_2006_fb_tweet)
~~~



~~~{.output}
[1] 13

~~~

As we have seen, `filter` works with any expression that evaluates to a logical vector.
Thus we can use `grepl` to search for patterns.
How many of these articles with early social media coverage in 2006 involved infectious disease research?


~~~{.r}
research_2006_fb_tweet_disease <- filter(research, year == 2006,
                                 facebookCommentCount > 0 | backtweetsCount > 0,
                                 grepl("Infectious Diseases", plosSubjectTags))
nrow(research_2006_fb_tweet_disease)
~~~



~~~{.output}
[1] 3

~~~


> ##  {.challenge}
>
> How many articles were published in 2009?
> How many of these had at least one Tweet or Facebook comment?
> How many were in at least one Mendeley user's library (mendeleyReadersCount)?



