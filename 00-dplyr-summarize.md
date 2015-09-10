---
layout: page
title: Intermediate programming with R
subtitle: Summarizing with dplyr
minutes: 30
---



> ## Learning Objectives {.objectives}
>
> *  Create new columns using `mutate`
> *  Summarize data using `summarize`
> *  Count number of observations using `n()`
> *  Group data by variable(s) with `group_by`








At this point we have only used dplyr to subset and organize our data.
But of course we can also create new data.
And the true power of dplyr is revealed when we perform these operations by groups.

### Create new columns with `mutate`

To create a new column in the data frame, we use `mutate`.
Let's create a new column that is the number of weeks since the article was published.


~~~{.r}
research <- mutate(research, weeksSincePublished = daysSincePublished / 7)
~~~

As before, the dplyr version is quicker to type than the traditional R version.


~~~{.r}
research$weeksSincePublished <- research$daysSincePublished / 7
~~~

Another benefit is that we can instantly reference the new variables we have created.
For example, we can create a variable `yearsSincePublished` referencing the newly created `weeksSincePublished`.


~~~{.r}
research <- mutate(research, weeksSincePublished = daysSincePublished / 7,
                             yearsSincePublished = weeksSincePublished / 52)
select(research, contains("Since")) %>% slice(1:10)
~~~



~~~{.output}
   daysSincePublished weeksSincePublished yearsSincePublished
1                2628            375.4286            7.219780
2                2593            370.4286            7.123626
3                2684            383.4286            7.373626
4                2684            383.4286            7.373626
5                2628            375.4286            7.219780
6                2628            375.4286            7.219780
7                2656            379.4286            7.296703
8                2656            379.4286            7.296703
9                2628            375.4286            7.219780
10               2628            375.4286            7.219780

~~~

### Summarize data using `summarize`

We use `mutate` when the result has the same number of rows as the original data.
When we need to reduce the data to a single summary statistic, we can use `summarize`.
For example, let's calculate a summary statistic which is the mean number of PLOS comments.


~~~{.r}
summarize(research, plosMean = mean(plosCommentCount))
~~~



~~~{.output}
   plosMean
1 0.2642681

~~~

And we can additional statistics, like the standard deviation:


~~~{.r}
summarize(research, plosMean = mean(plosCommentCount), plosSD = sd(plosCommentCount))
~~~



~~~{.output}
   plosMean   plosSD
1 0.2642681 1.230676

~~~

Notice that this creates a second column in the data frame result.

And of course we can pipe input to `summarize`.
Let's calculate these statistics specifically for the articles in PLOS One published in 2007.


~~~{.r}
research %>% filter(journal == "pone", year == 2007) %>%
  summarize(plosMean = mean(plosCommentCount), plosSD = sd(plosCommentCount))
~~~



~~~{.output}
   plosMean   plosSD
1 0.8315704 2.033141

~~~

Lastly, since it is often useful to know how many observations, in this case articles, are present in a given subset, dplyr provides the convenience function `n()`.


~~~{.r}
research %>% filter(journal == "pone", year == 2007) %>%
  summarize(plosMean = mean(plosCommentCount), plosSD = sd(plosCommentCount),
            num = n())
~~~



~~~{.output}
   plosMean   plosSD  num
1 0.8315704 2.033141 1229

~~~

### Summarizing per group with `group_by`

The function `summarize` is most powerful when applied to grouping of the data.
dplyr makes the code much easier to write, understand, and extend.

Recall the function we wrote earlier to sum a metric for each level of a factor.


~~~{.r}
sum_metric_per_var <- function(metric, variable) {
  result <- numeric(length = length(levels(variable)))
  names(result) <- levels(variable)
  for (v in levels(variable)) {
    result[v] <- sum(metric[variable == v])
  }
  return(result)
}
~~~

Which we ran as the following.


~~~{.r}
sum_metric_per_var(research$backtweetsCount, research$journal)
~~~



~~~{.output}
pbio pcbi pgen pmed pntd pone ppat 
  77  171  106  200   16 6941   38 

~~~

We can perform the same operation by combining `summarize` with `group_by`


~~~{.r}
research %>% group_by(journal) %>% summarize(tweetsSum = sum(backtweetsCount))
~~~



~~~{.output}
Source: local data frame [7 x 2]

  journal tweetsSum
1    pbio        77
2    pcbi       171
3    pgen       106
4    pmed       200
5    pntd        16
6    pone      6941
7    ppat        38

~~~

Conveniently it returns the result as a data frame.
And if we want to further group it by another factor, we can just add it to the `group_by` function.


~~~{.r}
research %>% group_by(journal, year) %>% summarize(tweetsSum = sum(backtweetsCount))
~~~



~~~{.output}
Source: local data frame [42 x 3]
Groups: journal

   journal year tweetsSum
1     pbio 2003         0
2     pbio 2004         0
3     pbio 2005         2
4     pbio 2006         2
5     pbio 2007         1
6     pbio 2008         6
7     pbio 2009         1
8     pbio 2010        65
9     pcbi 2005         0
10    pcbi 2006         0
..     ...  ...       ...

~~~

In the function we wrote to do this manually, we would have had to write another `for` loop!

### Challenges

> ## Summarizing the number of tweets per journal {.challenge}
>
> Create a new data frame, `tweets_per_journal`, that for each journal contains
> the total number of articles,
> the mean number of tweets received by articles in that journal,
> and the standard error of the mean (SEM) of the number of tweets.
> The SEM is the standard deviation divided by the square root of the sample size (i.e. the number of articles).



