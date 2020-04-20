require(ggplot2)
require(gridExtra)
library(tidyverse)
library(grid)

cnvs <- read_csv('sig_genes_by_cancer.csv')

endo_cnvs = pull(cnvs, ENDO)
gbm_cnvs = pull(cnvs, GBM)
luad_cnvs = pull(cnvs, LUAD)
brca_cnvs = pull(cnvs, BRCA)
hnscc_cnvs = pull(cnvs, HNSCC)
ovarian_cnvs = pull(cnvs, OVARIAN)
ccrcc_cnvs = pull(cnvs, CCRCC)

cancer_types = c()

endo_gbm = Reduce(intersect, list(endo_cnvs, gbm_cnvs))
endo_luad = Reduce(intersect, list(endo_cnvs, luad_cnvs))
endo_brca = Reduce(intersect, list(endo_cnvs, brca_cnvs))
endo_hnscc = Reduce(intersect, list(endo_cnvs, hnscc_cnvs))
endo_ovarian = Reduce(intersect, list(endo_cnvs, ovarian_cnvs))
endo_ccrcc = Reduce(intersect, list(endo_cnvs, ccrcc_cnvs))
gbm_luad = Reduce(intersect, list(gbm_cnvs, luad_cnvs))
gbm_brca = Reduce(intersect, list(gbm_cnvs, brca_cnvs))
gbm_hnscc = Reduce(intersect, list(gbm_cnvs, hnscc_cnvs))
gbm_ovarian = Reduce(intersect, list(gbm_cnvs, ovarian_cnvs))
gbm_ccrcc = Reduce(intersect, list(gbm_cnvs, ccrcc_cnvs))
luad_brca = Reduce(intersect, list(luad_cnvs, brca_cnvs))
luad_hnscc = Reduce(intersect, list(luad_cnvs, hnscc_cnvs))
luad_ovarian = Reduce(intersect, list(luad_cnvs, ovarian_cnvs))
luad_ccrcc = Reduce(intersect, list(luad_cnvs, ccrcc_cnvs))
brca_hnscc = Reduce(intersect, list(brca_cnvs, hnscc_cnvs))
brca_ovarian = Reduce(intersect, list(brca_cnvs, ovarian_cnvs))
brca_ccrcc = Reduce(intersect, list(brca_cnvs, ccrcc_cnvs))
hnscc_ovarian = Reduce(intersect, list(hnscc_cnvs, ovarian_cnvs))
hnscc_ccrcc = Reduce(intersect, list(hnscc_cnvs, ccrcc_cnvs))
ovarian_ccrcc = Reduce(intersect, list(ovarian_cnvs, ccrcc_cnvs))


data = tribble( ~pair, ~count,
"endo_gbm", length(Reduce(intersect, list(endo_cnvs, gbm_cnvs))),
"endo_luad", length(Reduce(intersect, list(endo_cnvs, luad_cnvs))),
"endo_brca", length(Reduce(intersect, list(endo_cnvs, brca_cnvs))),
"endo_hnscc", length(Reduce(intersect, list(endo_cnvs, hnscc_cnvs))),
"endo_ovarian", length(Reduce(intersect, list(endo_cnvs, ovarian_cnvs))),
"endo_ccrcc", length(Reduce(intersect, list(endo_cnvs, ccrcc_cnvs))),
"gbm_luad", length(Reduce(intersect, list(gbm_cnvs, luad_cnvs))),
"gbm_brca", length(Reduce(intersect, list(gbm_cnvs, brca_cnvs))),
"gbm_hnscc", length(Reduce(intersect, list(gbm_cnvs, hnscc_cnvs))),
"gbm_ovarian", length(Reduce(intersect, list(gbm_cnvs, ovarian_cnvs))),
"gbm_ccrcc", length(Reduce(intersect, list(gbm_cnvs, ccrcc_cnvs))),
"luad_brca", length(Reduce(intersect, list(luad_cnvs, brca_cnvs))),
"luad_hnscc", length(Reduce(intersect, list(luad_cnvs, hnscc_cnvs))),
"luad_ovarian", length(Reduce(intersect, list(luad_cnvs, ovarian_cnvs))),
"luad_ccrcc", length(Reduce(intersect, list(luad_cnvs, ccrcc_cnvs))),
"brca_hnscc", length(Reduce(intersect, list(brca_cnvs, hnscc_cnvs))),
"brca_ovarian", length(Reduce(intersect, list(brca_cnvs, ovarian_cnvs))),
"brca_ccrcc", length(Reduce(intersect, list(brca_cnvs, ccrcc_cnvs))),
"hnscc_ovarian", length(Reduce(intersect, list(hnscc_cnvs, ovarian_cnvs))),
"hnscc_ccrcc", length(Reduce(intersect, list(hnscc_cnvs, ccrcc_cnvs))),
"ovarian_ccrcc", length(Reduce(intersect, list(ovarian_cnvs, ccrcc_cnvs)))
)
data = arrange(data, count)
ggplot(data, aes(x=reorder(pair, -count), y=count)) +
  geom_col(position = 'dodge') + 
  geom_text(aes(label=count), position=position_dodge(width=0.9), vjust=-0.25) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  xlab("Cancer Pair") +
  ylab("Common CNVs")