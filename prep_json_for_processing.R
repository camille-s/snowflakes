library(tidyverse)
library(jsonlite)

json <- read_csv("snowfall.csv") %>%
  # filter(str_detect(name, "(Bridgeport|Groton|Hartford)")) %>%
  mutate(name = str_replace(name, "(?<=(Mt|East))\\s", "_")) %>%
  mutate(name = str_extract(name, "^\\w+")) %>%
  mutate(name = str_replace_all(name, "_", " ")) %>%
  rename(city = name) %>%
  group_by(city) %>%
  nest()

json %>%
  filter(city %in% c("Bridgeport", "Danbury", "Hartford")) %>%
  write_json("snowflakes_processing/data/snow.json", pretty = T)


# for legend
snow <- read_csv("snowfall.csv")

snow %>%
  # filter(city == "Bridgeport") %>%
  # pull(data) %>%
  # `[[`(1) %>%
  ggplot(aes(x = date)) +
  geom_histogram() +
  facet_wrap(~ name)

json %>%
  filter(city %in% c("Burlington")) %>%
  write_json("snowflakes_processing/data/snow_example.json", pretty = T)
