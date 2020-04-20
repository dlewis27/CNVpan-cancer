# Distrbibution

require(ggplot2)
require(gridExtra)
library(tidyverse)
library(grid)

brca_data <- read_csv('brca_counts.csv')
cutoffs <- read_csv('cutoffs.csv')

brca_high = t(brca_data)
colnames(brca_high) = c('id', 'high', 'neutral', 'low', 'average')
brca_high = as_tibble(brca_high[-1,]) %>%
  mutate(high = as.numeric(high))

plt = ggplot(brca_high, aes(high)) +
  geom_histogram() +
  geom_vline(xintercept=cutoff, color='red') +
  theme_bw() +
  xlab("Number of Samples") +
  ylab("Number of Genes")

plt
