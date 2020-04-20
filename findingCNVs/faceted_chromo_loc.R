require(ggplot2)
require(gridExtra)
library(tidyverse)
library(grid)

sig_genes = read_csv("sig_genes_by_cancer.csv")
chromosomes = read_csv("uniprot_chromosomes.csv")

sig_genes = sig_genes %>%
  gather(key="cancer", value="gene")

chromosomes = chromosomes %>%
  mutate(chromosome = str_extract(chromosome, '[0-9,X,Y]+'))

df = inner_join(sig_genes, chromosomes) %>%
  drop_na(chromosome) %>%
  filter(cancer!='ENDO' | chromosome!='Y')


df[df=='NA'] <- NA
df = drop_na(df, chromosome)

fig1=ggplot(df, aes(factor(chromosome, levels=c('1', '2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21', '22','X','Y')))) + 
  geom_bar() +
  facet_wrap(cancer~., drop=TRUE) +
  theme_bw() +
  xlab("Chromosome") +
  ylab('Number of Genes') +
  scale_x_discrete(labels=c('1', ' ' , '3', ' ','5', ' ' , '7', ' ' ,'9', ' ' , '11' ,' ' ,'13' , ' ' ,'15', ' ' ,'17', ' ' , '19' ,' ' , '21' , ' ' ,'X', 'Y'))

fig1



