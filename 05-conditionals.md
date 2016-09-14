---
layout: page
title: Intermediate programming with R
subtitle: Conditional statements
minutes: 30
---



> ## Learning Objectives {.objectives}
>
> *  Filter using logical vectors created with conditional statements
> *  Search for patterns with `grepl`
> *  Make decisions with `if` and `else` statements



In the previous lesson, we were introduced to logical vectors with the functions `is.na` and `anyNA`.


~~~{.r}
counts_raw$authorsCount[1:10]
~~~



~~~{.output}
 [1]  6 14 NA NA  6 10 NA NA NA  5

~~~



~~~{.r}
is.na(counts_raw$authorsCount[1:10])
~~~



~~~{.output}
 [1] FALSE FALSE  TRUE  TRUE FALSE FALSE  TRUE  TRUE  TRUE FALSE

~~~



~~~{.r}
anyNA(counts_raw$authorsCount[1:10])
~~~



~~~{.output}
[1] TRUE

~~~

In this lesson we will learn how these types of logical vectors can be used for filtering data and making decisions.

### Filtering with logical vectors

Instead of providing the numbers of the rows we want, we can filter with a logical vector.


~~~{.r}
counts_raw$authorsCount[1:10]
~~~



~~~{.output}
 [1]  6 14 NA NA  6 10 NA NA NA  5

~~~



~~~{.r}
counts_raw$authorsCount[1:10] > 7
~~~



~~~{.output}
 [1] FALSE  TRUE    NA    NA FALSE  TRUE    NA    NA    NA FALSE

~~~



~~~{.r}
dim(counts_raw[counts_raw$authorsCount > 7, ])
~~~



~~~{.output}
[1] 10348    32

~~~

Here we filtered the data to only include the 10348 rows where the number of authors was greater than 7. 

To filter for equality or non-equality, use `==` or `!=`:


~~~{.r}
# All the articles published in the journal PLOS One
dim(counts_raw[counts_raw$journal == "pone", ])
~~~



~~~{.output}
[1] 14099    32

~~~



~~~{.r}
# All the articles NOT published in the journal PLOS One
dim(counts_raw[counts_raw$journal != "pone", ])
~~~



~~~{.output}
[1] 10232    32

~~~

Here are the other possibilities:

* `>` - "greater than"
* `<` - "less than"
* `>=` - "greater than or equal to"
* `<=` - "less than or equal to"
* `==` - "equal to"
* `!=` - "not equal to"

These logical conditions can be combined into more complex filters using the ampersand `&` ("and") or vertical bar `|` ("or") operators.


~~~{.r}
# All the articles published in the journal PLOS One AND with more than 7 authors
dim(counts_raw[counts_raw$journal == "pone" &
               counts_raw$authorsCount > 7, ])
~~~



~~~{.output}
[1] 4697   32

~~~



~~~{.r}
# All the articles published in the journal PLOS One OR the journal PLOS Biology
dim(counts_raw[counts_raw$journal == "pone" |
               counts_raw$journal == "pbio", ])
~~~



~~~{.output}
[1] 16690    32

~~~

When we are checking one vector for multiple possibilities, it is more convenient to use the operator `%in%` instead of creating multiple "or" conditions.


~~~{.r}
# All the articles published in the journals PLOS One, PLOS Biology, or PLOS Genetics
dim(counts_raw[counts_raw$journal %in% c("pone", "pbio", "pgen"), ])
~~~



~~~{.output}
[1] 18459    32

~~~

Lastly, to reverse any logical vector, we can append the exclamation point `!` for "NOT".


~~~{.r}
# All the articles NOT published in the journals PLOS One, PLOS Biology, or PLOS Genetics
dim(counts_raw[!(counts_raw$journal %in% c("pone", "pbio", "pgen")), ])
~~~



~~~{.output}
[1] 5872   32

~~~

### Finding patterns with `grepl`

We saw in the Unix shell that we could search for lines in a file that contain a specific pattern using `grep`.
R provides similar functionality.
`grepl` searches each element of a vector for a given pattern and returns `TRUE` if it finds it, and `FALSE` otherwise.
Let's try it out using the column `plosSubjectTags`, which describes the scientific discipline(s) of the article.


~~~{.r}
head(counts_raw$plosSubjectTags)
~~~



~~~{.output}
[1] Cell Biology|Immunology|Molecular Biology                                             
[2] Biotechnology|Genetics and Genomics|Infectious Diseases|Virology                      
[3] Computational Biology|Biotechnology|Genetics and Genomics|Infectious Diseases|Virology
[4] Cell Biology|Immunology|Molecular Biology                                             
[5] Genetics and Genomics|Infectious Diseases|Microbiology                                
[6] Ecology|Evolutionary Biology|Genetics and Genomics                                    
6715 Levels: Anesthesiology and Pain Management ...

~~~

How many of the articles have to do with "Immunology"?


~~~{.r}
dim(counts_raw[grepl("Immunology", counts_raw$plosSubjectTags), ])
~~~



~~~{.output}
[1] 2708   32

~~~

The first argument `grepl` was the string we were searching for, and the second argument was the vector to be searched.

How many of the immunology articles were published in PLOS Medicine.


~~~{.r}
dim(counts_raw[grepl("Immunology", counts_raw$plosSubjectTags) &
                 counts_raw$journal == "pmed", ])
~~~



~~~{.output}
[1] 194  32

~~~

> ## grepl vs. grep {.callout}
>
> `grepl` returns a logical vector.
> Another option is to use `grep`.
> Instead it returns the indices of the elements that contain the pattern.
> In most cases the result will be the same, but you'll have to use the correct one if you find a situation that requires only logical vectors or index positions.

### Making decisions

In addition to filtering, we can use conditional statements to adapt the behavior of the code based on the input data.
We do this using `if` and `else` statements.
The basic structure is the following:


~~~{.r}
if (condition is TRUE) {
  do something
} else {
  do a different thing
}
~~~

For example, we can check whether a vector contains any missing values.


~~~{.r}
x <- counts_raw$authorsCount
if (anyNA(x)) {
  print("Be careful! The data contains missing values.")
} else {
  print("Looks good. The data does NOT contain missing values.")
}
~~~



~~~{.output}
[1] "Be careful! The data contains missing values."

~~~

Or we can check if an object is a specific data type, and convert it to the one we need.
Here we convert the column `title` from a factor to a character vector.


~~~{.r}
x <- counts_raw$title
if (!is.character(x)) {
  x <- as.character(x)
}
~~~

### Challenges

> ## Filtering articles {.challenge}
>
> How many articles with the subject tag (`plosSubjectTags`) "Evolutionary Biology" were published in either PLOS One ("pone"), PLOS Biology ("pbio"), or PLOS Medicine ("pmed")?


