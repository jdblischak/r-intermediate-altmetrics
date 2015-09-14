---
layout: page
title: Intermediate programming with R
subtitle: Defensive programming with testit
minutes: 30
---



> ## Learning Objectives {.objectives}
>
> * Write assertion statements with `assert`
> * Confirm errors using `has_error`
> * Confirm warnings using `has_warning`
> * Use unit tests to confirm code is working as expected




~~~{.r}
library("testit")
~~~




~~~{.r}
calc_sum_stat <- function(df, cols) {
  stopifnot(dim(df) > 0,
            is.character(cols),
            cols %in% colnames(df))
  if (length(cols) == 1) {
    warning("Only one column specified. Calculating the mean will not change anything.")
  }
  df_sub <- df[, cols, drop = FALSE]
  stopifnot(is.data.frame(df_sub))
  sum_stat <- apply(df_sub, 1, mean)
  stopifnot(!is.na(sum_stat))
  return(sum_stat)
}
# Proper
sum_stat <- calc_sum_stat(counts_raw, c("wosCountThru2010", "f1000Factor"))
~~~


~~~{.r}
# Empty data frame
assert("Empty data frame throws error",
       has_error(calc_sum_stat(data.frame(),
                               c("wosCountThru2010", "f1000Factor"))))
# Non-character cols
assert("Non-character vector input for columns throws error",
       has_error(calc_sum_stat(counts_raw, 1:3)))
# Bad column names
assert("Column names not in data frame throws error",
       has_error(calc_sum_stat(counts_raw, c("a", "b"))))
# Issue warning since only one column
assert("Selecting only one column issues warning",
       has_warning(calc_sum_stat(counts_raw, "mendeleyReadersCount")))
# NA output
assert("NA in output throws error",
       has_error(calc_sum_stat(counts_raw,
                     c("wosCountThru2010", "facebookLikeCount"))))
~~~



### Challenge

> ## Write some tests {.challenge}
>
> Write tests for the function `my_mean` that you wrote in an earlier lesson.
> It should look something like this:
>
> 
> ~~~{.r}
> my_mean <- function(x) {
>   result <- sum(x) / length(x)
>   return(result)
> }
> ~~~
> 
> The input `x` is a numeric vector, and the output is the mean of the vector of numbers.
> Some ideas to get started:
>
> * Pass a vector where you know what the mean is, and assert that the result is correct
> * Include an `NA` in the vector where you know the result to see what happens.
Do you need to modify the code to pass the test?
> * Add some assertion statments to check the input `x`.
> Use `has_error` to test that the function throws an error when given bad input.
> * What should the function do if the user passes a vector of length one?
> Should a warning be issued to alert the user?