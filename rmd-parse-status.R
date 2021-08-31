library(parsermd)
library(dplyr)

rmd = parsermd::parse_rmd("incr-infe.Rmd")
rmd_tbl = as_tibble(rmd)

by_section =
rmd_tbl %>%
  group_by(sec_h2, sec_h3) %>%
  summarize(
    has_code = sum(type == "rmd_chunk") > 0,
    has_text = sum(type == "rmd_markdown") > 0
  ) %>%
  ungroup()

by_section %>%
  summarize(
    across(starts_with("has"), mean),
    has_code_only = mean(has_code * !has_text),
    has_text_only = mean(has_text * !has_code)
    )

