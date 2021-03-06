# Gene Counts by Cancer

require(ggplot2)
require(gridExtra)
library(tidyverse)
library(grid)

sig_genes_by_cancer <- read_csv("sig_genes_by_cancer.csv")
data = sig_genes_by_cancer %>%
  gather(key='cancer', value='gene', -1) %>%
  drop_na() %>%
  group_by(cancer) %>%
    summarise(
      counts = n()
    )

ggplot(data, aes(x=reorder(cancer, -counts), y=counts)) +
  geom_col(position='dodge', stat='identity') +
  xlab('Cancer Type') +
  ylab('Number of Genes') +
  geom_text(aes(label=counts), position=position_dodge(width=0.9), vjust=-0.25) +
  theme_bw()