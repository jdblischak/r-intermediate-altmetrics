

```r
subdir <- "data/"
dir.create(subdir, showWarnings = FALSE)
```



```r
base_url <- "https://github.com/downloads/jasonpriem/plos_altmetrics_study/"
files <- c(
  # Article metadata and aggregated counts for all crawler-collected indicators
  "raw_crawler_eventcounts.txt.gz",
  # all indicator eventcounts, normalized and transformed
  "df_research_norm_transform.txt.gz",
  # all indicator eventcounts, unnormalized
  "df_all.txt.gz",
  # Article metadata and counts of all alt-metrics event types
  "raw_event_counts.txt.zip",
  # counts of events occuring within 90 days of the articles they point to, by year+quarter and journal
  "event_trends.txt",
  # metadata for each event (tweet, bookmark, etc) 
  "raw_events.txt.zip"
  )
for (fname in files) {
  fname_full <- file.path(subdir, fname)
  if (!file.exists(fname_full)) {
    download.file(url = paste0(base_url, fname),
                  destfile = file.path(subdir, fname))
  }
}
```

## raw_crawler_eventcounts.txt.gz
 
Article metadata and aggregated counts for all crawler-collected indicators
  "raw_crawler_eventcounts.txt.gz",
  

```r
raw_crawler <- read.delim(gzfile(file.path(subdir, "raw_crawler_eventcounts.txt.gz")),
                          stringsAsFactors = FALSE)
```


```r
dim(raw_crawler)
```

```
## [1] 24334    28
```

```r
colnames(raw_crawler)
```

```
##  [1] "doi"                       "pubDate"                  
##  [3] "journal"                   "title"                    
##  [5] "articleType"               "authorsCount"             
##  [7] "f1000Factor"               "backtweetsCount"          
##  [9] "deliciousCount"            "pmid"                     
## [11] "plosSubjectTags"           "plosSubSubjectTags"       
## [13] "facebookShareCount"        "facebookLikeCount"        
## [15] "facebookCommentCount"      "facebookClickCount"       
## [17] "mendeleyReadersCount"      "almBlogsCount"            
## [19] "pdfDownloadsCount"         "xmlDownloadsCount"        
## [21] "htmlDownloadsCount"        "almCiteULikeCount"        
## [23] "almScopusCount"            "almPubMedCentralCount"    
## [25] "almCrossRefCount"          "plosCommentCount"         
## [27] "plosCommentResponsesCount" "wikipediaCites"
```

## df_research_norm_transform.txt.gz

This is the data set used for most of the publication.

all indicator eventcounts, normalized and transformed

df_research_norm_transform.txt.gz


```r
events_norm <- read.delim(gzfile(file.path(subdir, "df_research_norm_transform.txt.gz")),
                          stringsAsFactors = FALSE)
```


```r
dim(events_norm)
```

```
## [1] 21096    32
```

```r
colnames(events_norm)
```

```
##  [1] "doi"                       "pubDate"                  
##  [3] "journal"                   "title"                    
##  [5] "articleType"               "authorsCount"             
##  [7] "f1000Factor"               "backtweetsCount"          
##  [9] "deliciousCount"            "pmid"                     
## [11] "plosSubjectTags"           "plosSubSubjectTags"       
## [13] "facebookShareCount"        "facebookLikeCount"        
## [15] "facebookCommentCount"      "facebookClickCount"       
## [17] "mendeleyReadersCount"      "almBlogsCount"            
## [19] "pdfDownloadsCount"         "xmlDownloadsCount"        
## [21] "htmlDownloadsCount"        "almCiteULikeCount"        
## [23] "almScopusCount"            "almPubMedCentralCount"    
## [25] "almCrossRefCount"          "plosCommentCount"         
## [27] "plosCommentResponsesCount" "wikipediaCites"           
## [29] "year"                      "daysSincePublished"       
## [31] "wosCountThru2010"          "wosCountThru2011"
```

## df_all.txt.gz

This file contains all the altmetrics event counts prior to filtering out non-research articles.

all indicator eventcounts, unnormalized

df_all.txt.gz


```r
df_all <- read.delim(gzfile(file.path(subdir, "df_all.txt.gz")),
                     stringsAsFactors = FALSE)
```


```r
dim(df_all)
```

```
## [1] 24331    32
```

```r
colnames(df_all)
```

```
##  [1] "doi"                       "pubDate"                  
##  [3] "journal"                   "title"                    
##  [5] "articleType"               "authorsCount"             
##  [7] "f1000Factor"               "backtweetsCount"          
##  [9] "deliciousCount"            "pmid"                     
## [11] "plosSubjectTags"           "plosSubSubjectTags"       
## [13] "facebookShareCount"        "facebookLikeCount"        
## [15] "facebookCommentCount"      "facebookClickCount"       
## [17] "mendeleyReadersCount"      "almBlogsCount"            
## [19] "pdfDownloadsCount"         "xmlDownloadsCount"        
## [21] "htmlDownloadsCount"        "almCiteULikeCount"        
## [23] "almScopusCount"            "almPubMedCentralCount"    
## [25] "almCrossRefCount"          "plosCommentCount"         
## [27] "plosCommentResponsesCount" "wikipediaCites"           
## [29] "year"                      "daysSincePublished"       
## [31] "wosCountThru2010"          "wosCountThru2011"
```

Need to use this file to get `df_research`.

https://github.com/jasonpriem/plos_altmetrics_study/blob/master/stats/scripts/create_df_research.R

## raw_event_counts.txt.zip

Article metadata and counts of all alt-metrics event types

"raw_event_counts.txt.zip"


```r
raw_event_counts <- read.delim(unz(file.path(subdir, "raw_event_counts.txt.zip"),
                                   filename = "raw_event_counts.txt"),
                          stringsAsFactors = FALSE)
```


```r
dim(raw_event_counts)
```

```
## [1] 24334    28
```

```r
colnames(raw_event_counts)
```

```
##  [1] "doi"                       "pubDate"                  
##  [3] "journal"                   "title"                    
##  [5] "articleType"               "authorsCount"             
##  [7] "f1000Factor"               "backtweetsCount"          
##  [9] "deliciousCount"            "pmid"                     
## [11] "plosSubjectTags"           "plosSubSubjectTags"       
## [13] "facebookShareCount"        "facebookLikeCount"        
## [15] "facebookCommentCount"      "facebookClickCount"       
## [17] "mendeleyReadersCount"      "almBlogsCount"            
## [19] "pdfDownloadsCount"         "xmlDownloadsCount"        
## [21] "htmlDownloadsCount"        "almCiteULikeCount"        
## [23] "almScopusCount"            "almPubMedCentralCount"    
## [25] "almCrossRefCount"          "plosCommentCount"         
## [27] "plosCommentResponsesCount" "wikipediaCites"
```

## event_trends.txt

counts of events occuring within 90 days of the articles they point to, by year+quarter and journal

"event_trends.txt"


```r
event_trends <- read.table(file.path(subdir, "event_trends.txt"),
                          header = TRUE, sep = "\t", stringsAsFactors = FALSE)
```


```r
dim(event_trends)
```

```
## [1] 196  23
```

```r
colnames(event_trends)
```

```
##  [1] "qtr"                                     
##  [2] "journal"                                 
##  [3] "articles.published"                      
##  [4] "articles.with.backtweets"                
##  [5] "total.backtweets"                        
##  [6] "articles.with.citeulike"                 
##  [7] "total.citeulike"                         
##  [8] "articles.with.delicious"                 
##  [9] "total.delicious"                         
## [10] "articles.with.html.views"                
## [11] "total.html.views"                        
## [12] "articles.with.native.comments"           
## [13] "total.native.comments"                   
## [14] "articles.with.Nature.via.Plos"           
## [15] "total.Nature.via.Plos"                   
## [16] "articles.with.pdf.views"                 
## [17] "total.pdf.views"                         
## [18] "articles.with.Postgenomic.via.Plos"      
## [19] "total.Postgenomic.via.Plos"              
## [20] "articles.with.Research.Blogging.via.Plos"
## [21] "total.Research.Blogging.via.Plos"        
## [22] "articles.with.xml.views"                 
## [23] "total.xml.views"
```

# raw_events.txt.zip

metadata for each event (tweet, bookmark, etc) 

"raw_events.txt.zip"


```r
raw_events <- read.delim(unz(file.path(subdir, "raw_events.txt.zip"),
                             filename = "raw_events.txt"),
                          stringsAsFactors = FALSE)
```


```r
dim(raw_events)
```

```
## [1] 1816131       7
```

```r
colnames(raw_events)
```

```
## [1] "eventType" "doi"       "creator"   "date"      "latency"   "value"    
## [7] "count"
```

