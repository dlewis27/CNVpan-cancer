require(ggplot2)
require(gridExtra)
library(tidyverse)
library(grid)

chromosomes <- read_csv('uniprot_chromosomes.csv')
cnvs <- read_csv('sig_genes_by_cancer.csv')
sig_genes <- read_csv('sig_genes.csv')

get_legend<-function(myggplot){
  tmp <- ggplot_gtable(ggplot_build(myggplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  return(legend)
}

chromosomes = chromosomes %>%
  mutate(chromosome = str_extract(chromosome, '[0-9,X,Y]+')) %>%
  mutate(chromosome = factor(chromosome, levels=c('1', '2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21', '22','X','Y'))) %>%
  drop_na() %>%
  select(-X1)


cnv_data = cnvs %>%
  gather(key="cancer", value="gene")

data1 = cnv_data %>%
  left_join(chromosomes) %>%
  drop_na()

plt1 = ggplot(data1, aes(x=chromosome, fill=cancer)) +
  geom_bar(position='dodge') +
  xlab("Chromosome") +
  ylab("Number of Genes") +
  labs(title="A", fill="Cancer Type") +
  theme_bw()

legend = get_legend(plt1)

plt1 = plt1 + theme(legend.position = "none")

data = filter(data1, gene %in% pull(sig_genes, gene))

plt2 = ggplot(data, aes(x=chromosome, fill=cancer)) +
  geom_bar(position='dodge') +
  xlab("Chromosome") + 
  ylab("Number of Genes") +
  labs(title="B") +
  theme_bw() +
  theme(legend.position = "none")

plt2




g1 = grid.arrange(
  plt1, plt2,
  widths = c(1),
  nrow=2,
  layout_matrix = rbind(c(1), c(2)))

g2 = grid.arrange(
  g1, legend,
  widths = c(5,1),
  layout_matrix = rbind(c(1,2))
)