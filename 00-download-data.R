## setup-
subdir <- "data/"
dir.create(subdir, showWarnings = FALSE)

##
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

##
raw_crawler <- read.delim(gzfile(file.path(subdir, "raw_crawler_eventcounts.txt.gz")),
                          stringsAsFactors = FALSE)

##
dim(raw_crawler)
colnames(raw_crawler)

##
events_norm <- read.delim(gzfile(file.path(subdir, "df_research_norm_transform.txt.gz")),
                          stringsAsFactors = FALSE)

##
dim(events_norm)
colnames(events_norm)

##
df_all <- read.delim(gzfile(file.path(subdir, "df_all.txt.gz")),
                     stringsAsFactors = FALSE)

##
dim(df_all)
colnames(df_all)

##
raw_event_counts <- read.delim(unz(file.path(subdir, "raw_event_counts.txt.zip"),
                                   filename = "raw_event_counts.txt"),
                          stringsAsFactors = FALSE)

##
dim(raw_event_counts)
colnames(raw_event_counts)

##
event_trends <- read.table(file.path(subdir, "event_trends.txt"),
                          header = TRUE, sep = "\t", stringsAsFactors = FALSE)

##
dim(event_trends)
colnames(event_trends)

##
raw_events <- read.delim(unz(file.path(subdir, "raw_events.txt.zip"),
                             filename = "raw_events.txt"),
                          stringsAsFactors = FALSE)


##
dim(raw_events)
colnames(raw_events)

