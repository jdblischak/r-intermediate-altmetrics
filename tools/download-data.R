#!/usr/bin/env Rscript

# Download the data sets used for this lesson.

subdir <- "data/"
dir.create(subdir, showWarnings = FALSE)

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
