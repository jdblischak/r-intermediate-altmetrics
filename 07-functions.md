---
layout: page
title: Intermediate programming with R
subtitle: Functions
minutes: 30
---



> ## Learning Objectives {.objectives}
>
> *  Functions have two parts: arguments and body
> *  Functions have their own environment
> *  Convert code into functions to repeat operations

In the last lesson we wrote loops to performs some calculations.
But what if we wanted to perform similar calculations on different columns?
We would have to copy-paste the loops and change all the variable names.
This strategy would be both tedious, error prone, and difficult to update if we want to make a change.
To avoid these problems, we will review how to write our own functions.



### The parts of a function

We've already been using built-in R functions: `read.delim`, `mean`, `apply`, etc.
These functions allow us to run the same routine with different inputs.

Let's explore `read.delim` further.
All functions in R have two parts: the input arguments and the body.
We can see the arguments of a function with the `args`.


~~~{.r}
args(read.delim)
~~~



~~~{.output}
function (file, header = TRUE, sep = "\t", quote = "\"", dec = ".", 
    fill = TRUE, comment.char = "", ...) 
NULL

~~~

So when we pass a character vector like `"data/counts-raw.txt.gz"`, this gets assigned to the argument `file`.
All the other arguments have defaults set, so we do not need to assign them a value.

After the arguments have been assigned values, then the body of the function is executed.
We can view the body of a function with `body`.


~~~{.r}
body(read.delim)
~~~



~~~{.output}
read.table(file = file, header = header, sep = sep, quote = quote, 
    dec = dec, fill = fill, comment.char = comment.char, ...)

~~~

`read.delim` is very short.
It just calls another function, `read.table`, using the input file and the default arguments as the arguments passed to `read.table`.

When we define our own functions, we use the syntax below.
We list the arguments, separated by commas, within the parentheses.
The body follows, contained within curly brackets `{}`.


~~~{.r}
function_name <- function(args) {
  body
}
~~~

### The principle of encapsulation

An important feature of functions is the principle of encapsulation:
the environment inside the function is distinct from the environment outside the function.
In other words, variables defined inside a function are separate from variables defined outside the function.

Here's an small example to demonstrate this idea.
The function `ex_fun` takes two input arguments, `x` and `y`.
It calculates `w` and `z`, but only returns the value of `z`.


~~~{.r}
ex_fun <- function(x, y) {
  z <- x - y
  return(z)
}
~~~

When we run `ex_fun`, the only thing returned to the global environment is the value that was assigned to `z`.
The variable `z` itself was only defined in the function environment, and does not exist in the global environment.


~~~{.r}
ex_fun(3, 10)
~~~



~~~{.output}
[1] -7

~~~



~~~{.r}
z
~~~



~~~{.output}
Error in eval(expr, envir, enclos): object 'z' not found

~~~

> ## Environments are complicated {.challenge}
>
> The situation presented above is a simplified version of environments which will serve you well if you treat functions as truly encapsulated.
> In reality, things are more complicated.
> For example, if inside a function you have a variable that has not been defined in the function, it will actually search the global environment for this variable.
> To learn the advanced details, see the chapter [Environments](http://adv-r.had.co.nz/Environments.html) in Advanced R by Hadley Wickham.

> ## The return statement {.challenge}
>
> R provides the shortcut of not needing to use `return` at the end of the function.
> Instead, the variable on the last line of the body of the function is returned.
> This is useful for writing very small functions, but in these lessons we will use `return` to be more explicit about what is happening.

### Examples

In the last lesson we wrote the following `for` loop to calculate the mean number of citations for each journal.
Let's generalize this code to a function so that we can perform a similar calculation for any of the metrics across any of the categorical variables.


~~~{.r}
result <- numeric(length = length(levels(counts_raw$journal)))
names(result) <- levels(counts_raw$journal)
for (j in levels(counts_raw$journal)) {
  result[j] <- mean(counts_raw$wosCountThru2011[counts_raw$journal == j])
}
result
~~~



~~~{.output}
     pbio      pcbi      pgen      pmed      pntd      pone      ppat 
28.705905 14.219258 22.928208 18.148110  7.348564  8.306972 20.892613 

~~~

We'll name the function `mean_metric_per_var`,
and it will take two input arguments: `metric` and `variable`.
The outline of our function looks like this.


~~~{.r}
mean_metric_per_var <- function(metric, variable) {
  # body goes here
}
~~~

Now we can copy paste our loop code into the body of the function.
We indent the code by two spaces as a convention to aid readability, it doesn't actually affect the ability of the code to run (to indent in RStudio you can highlight all the lines and press Ctrl-I).


~~~{.r}
mean_metric_per_var <- function(metric, variable) {
  result <- numeric(length = length(levels(counts_raw$journal)))
  names(result) <- levels(counts_raw$journal)
  for (j in levels(counts_raw$journal)) {
    result[j] <- mean(counts_raw$wosCountThru2011[counts_raw$journal == j])
  }
  result
}
~~~

Now we need to replace the specific data we used, the journal and the 2011 citations, with the names of the function arguments.
We'll also add the `return`.


~~~{.r}
mean_metric_per_var <- function(metric, variable) {
  result <- numeric(length = length(levels(variable)))
  names(result) <- levels(variable)
  for (j in levels(variable)) {
    result[j] <- mean(metric[variable == j])
  }
  return(result)
}
~~~

Lastly, instead of naming the looping variable `j` for "journal", let's change it to `v` for "variable"


~~~{.r}
mean_metric_per_var <- function(metric, variable) {
  result <- numeric(length = length(levels(variable)))
  names(result) <- levels(variable)
  for (v in levels(variable)) {
    result[v] <- mean(metric[variable == v])
  }
  return(result)
}
~~~

Now we can run the same analysis we did before:


~~~{.r}
mean_metric_per_var(counts_raw$wosCountThru2011, counts_raw$journal)
~~~



~~~{.output}
     pbio      pcbi      pgen      pmed      pntd      pone      ppat 
28.705905 14.219258 22.928208 18.148110  7.348564  8.306972 20.892613 

~~~

Or a new analysis, like the mean number of tweets grouped by the type of article.


~~~{.r}
mean_metric_per_var(counts_raw$backtweetsCount, counts_raw$articleType)
~~~



~~~{.output}
                            Best Practice 
                               0.00000000 
         Book Review/Science in the Media 
                               0.00000000 
                              Case Report 
                               0.00000000 
                           Clinical Trial 
                               0.00000000 
                           Community Page 
                               0.10714286 
                               Correction 
                               0.00000000 
                           Correspondence 
                               0.00000000 
  Correspondence and Other Communications 
                               0.00000000 
                                Editorial 
                               0.82010582 
                                Education 
                               0.76470588 
                                    Essay 
                               0.52173913 
                        Expert Commentary 
                               0.00000000 
                                  Feature 
                               0.00000000 
           From Innovation to Application 
                               0.00000000 
                  Guidelines and Guidance 
                               0.00000000 
                         Health in Action 
                               0.07246377 
Historical and Philosophical Perspectives 
                               0.00000000 
     Historical Profiles and Perspectives 
                               0.00000000 
                                Interview 
                               0.03846154 
                             Journal Club 
                               0.25000000 
                           Learning Forum 
                               0.00000000 
                        Message from ISCB 
                               0.07142857 
                        Message from PLoS 
                               0.00000000 
                Message from the Founders 
                               0.00000000 
           Message from the PLoS Founders 
                               0.00000000 
                       Neglected Diseases 
                               0.00000000 
                                 Obituary 
                               0.00000000 
                                  Opinion 
                               0.32258065 
                                 Overview 
                               1.00000000 
                                   Pearls 
                               0.17391304 
                              Perspective 
                               0.10619469 
                               Photo Quiz 
                               0.00000000 
                             Policy Forum 
                               0.52380952 
                          Policy Platform 
                               0.00000000 
                                   Primer 
                               0.05755396 
                                     Quiz 
                               0.00000000 
                         Research Article 
                               0.35784035 
                  Research in Translation 
                               0.04081633 
                                   Review 
                               0.18354430 
                           Special Report 
                               0.00000000 
                            Student Forum 
                               0.00000000 
                                Symposium 
                               0.00000000 
                                 Synopsis 
                               0.02502980 
                         Technical Report 
                               0.00000000 
                               The Debate 
                               0.06666667 
                 The PLoS Medicine Debate 
                               0.33333333 
                         Unsolved Mystery 
                               0.05000000 
                               Viewpoints 
                               0.03225806 

~~~

The other loop we wrote used `apply` to calculate the mean of multiple metrics for each article, i.e. row, of the data frame.


~~~{.r}
counts_sub <- counts_raw[, c("wosCountThru2011", "backtweetsCount", "plosCommentCount")]
sum_stat <- apply(counts_sub, 1, mean)
summary(sum_stat)
~~~



~~~{.output}
    Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
  0.0000   0.6667   2.0000   4.7060   5.0000 245.7000 

~~~

Let's generalize this to a function where we can choose which columns to include in the mean summary statistic.
We'll call it `calc_sum_stat`,
and it will take two input arguments: the data frame and a vector of the columns to select.
Here's the outline of the function.


~~~{.r}
calc_sum_stat <- function(df, cols) {
}
~~~

Now we copy-paste our previous code into the body of the function and indent.


~~~{.r}
calc_sum_stat <- function(df, cols) {
  counts_sub <- counts_raw[, c("wosCountThru2011", "backtweetsCount", "plosCommentCount")]
  sum_stat <- apply(counts_sub, 1, mean)
  summary(sum_stat)
}
~~~

Also, replace the specific variable names with the argument names and add `return`.


~~~{.r}
calc_sum_stat <- function(df, cols) {
  df_sub <- df[, cols]
  sum_stat <- apply(df_sub, 1, mean)
  return(sum_stat)
}
~~~

Now we can perform the same analysis as before:


~~~{.r}
sum_stat_1 <- calc_sum_stat(counts_raw, c("wosCountThru2011", "backtweetsCount", "plosCommentCount"))
summary(sum_stat_1)
~~~



~~~{.output}
    Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
  0.0000   0.6667   2.0000   4.7060   5.0000 245.7000 

~~~

Or choose different metrics to summarize:


~~~{.r}
sum_stat_2 <- calc_sum_stat(counts_raw, c("wosCountThru2010", "f1000Factor"))
summary(sum_stat_2)
~~~



~~~{.output}
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  0.000   0.000   1.000   4.116   4.000 315.500 

~~~

As we have seen, writing functions allows us to repeat operations without having to copy-paste code.
In later lessons, we will learn how to debug functions when they are not working as expected.

### Challenges

> ## Write your own function {.challenge}
>
> Write your own function to calculate the mean called `my_mean`.
> Compare your results with the results from R's function `mean`.
> Do you receive the same answer?


