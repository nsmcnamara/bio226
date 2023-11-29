## SNP density analysis
## Aim: to calculate summary statistics and Wilcoxon rank sum test.
## This script is part of BIO226 - Project C.
## Miriam Binder, Simone McNamara
## Last update: 29. Nov. 2023

# SETUP --------------------

# load libraries
library(tidyverse)
library(conflicted)
library(rstatix)

# check for conflicts
conflict_scout()
conflicts_prefer(rstatix::filter)
conflicts_prefer(dplyr::lag)


# DATA ---------------------

## Female ------------------
# Read female autosome files and add group autosome
snpden_f <- lapply(1:8, function(i) {
  read.table(paste0("snpdens/snps_", i, "_female.snpden"), header = TRUE) |>
    mutate(GROUP = "autosome")
}) |>
  bind_rows()

# Read female sex chromosome file and add group sex
snpden_U_f <- read.table("snpdens/snps_U_female.snpden", header = TRUE) |>
  mutate(GROUP = "sex")

# Combine the data
snpden_f <- bind_rows(snpden_f, snpden_U_f) |>
  mutate(CHROM = as.factor(CHROM)) |>
  mutate(GROUP = as.factor(GROUP))

## Male --------------------
# Read male autosome files and add group autosome
snpden_m <- lapply(1:8, function(i) {
  read.table(paste0("snpdens/snps_", i, "_male.snpden"), header = TRUE) |>
    mutate(GROUP = "autosome")
}) |>
  bind_rows()

# Read male sex chromosome file and add group sex
snpden_V_m <- read.table("snpdens/snps_V_male.snpden", header = TRUE) |>
  mutate(GROUP = "sex")

# Combine the data
snpden_m <- bind_rows(snpden_m, snpden_V_m) |>
  mutate(CHROM = as.factor(CHROM)) |>
  mutate(GROUP = as.factor(GROUP))


# AUTOSOME vs SEX ----------------

## Variants per kb -----------
# calculate Variants per kb for autosome and sex chromosome

### female -----
snpden_f |>
  group_by(GROUP) |>
  get_summary_stats(VARIANTS.KB, type = "median_iqr")

# plot boxplot
boxplot_f <- ggplot(data = snpden_f,
       aes(x = CHROM, y = VARIANTS.KB, fill = GROUP)) +
  geom_boxplot(outlier.shape = NA, aes(fill = factor(GROUP))) +
  geom_jitter(mapping = aes(alpha = 0.01), width = 0.07, size = 0.001) +
  labs(x = "Chromosome",
       y = "SNP Density in variants/kb") +
  scale_alpha(guide = "none") +
  scale_fill_manual(values = c("aquamarine", "aquamarine4"), guide = "none") +
  theme_minimal(base_size = 15)
boxplot_f

# wilcoxon rank sum

stat.test_f <- snpden_f |>
  wilcox_test(VARIANTS.KB ~ GROUP) |>
  add_significance()
stat.test_f

snpden_f |> 
  wilcox_effsize(VARIANTS.KB ~ GROUP)

# export
ggsave("genetic_polymorphism_distribution_female.png", plot = boxplot_f)


### male -----
snpden_m |>
  group_by(GROUP) |>
  get_summary_stats(VARIANTS.KB, type = "median_iqr")


# plot boxplot
boxplot_m <- ggplot(data = snpden_m,
       aes(x = CHROM, y = VARIANTS.KB, fill = GROUP)) +
  geom_boxplot(outlier.shape = NA, aes(fill = factor(GROUP))) +
  geom_jitter(mapping = aes(alpha = 0.01), width = 0.07, size = 0.001) +
  labs(x = "Chromosome",
       y = "SNP Density in variants/kb") +
  scale_alpha(guide = "none") +
  scale_fill_manual(values = c("lightskyblue", "DodgerBlue"), guide = "none") +
  theme_minimal(base_size = 15)

boxplot_m

# wilcoxon rank sum

stat.test_m <- snpden_m |>
  wilcox_test(VARIANTS.KB ~ GROUP) |>
  add_significance()
stat.test_m

snpden_m |> 
  wilcox_effsize(VARIANTS.KB ~ GROUP)

# export
ggsave("genetic_polymorphism_distribution_male.png", plot = boxplot_m)

# LENGTH and DISTRIBUTION -------

# females ----
## length ----
snpden_f |>
  group_by(CHROM) |>
  get_summary_stats(BIN_START, show = c("max"))

snpden_f |>
  group_by(CHROM) |>
  get_summary_stats(VARIANTS.KB, show = c("mean"))



## dist ----
# distribution plots for all chromosomes
dist_f <- ggplot(snpden_f, aes(x = BIN_START, y = VARIANTS.KB, color = GROUP)) +
  geom_line() +
  geom_smooth(span = 0.1,se = FALSE, color = "black", linetype = "solid") +
  labs(x = "Chromosome Position",
       y = "SNP Density in variants/kb") +
  facet_wrap(~ CHROM) +
  scale_x_continuous(labels = scales::label_number(suffix = "Mb", scale = 1e-6)) +
  scale_color_manual(values = c("aquamarine", "aquamarine4"), guide = "none") +
  theme_minimal(base_size = 15)

dist_f

# export
ggsave("genetic_polymorphism_all_female.png", plot = dist_f)


# distribution plot for sex chromosome
dist_U <- snpden_f |>
  filter(CHROM == "chrU") |>
  ggplot(aes(x = BIN_START, y = VARIANTS.KB)) +
  geom_line(color = "aquamarine4") +
  geom_smooth(span = 0.1,se = FALSE, color = "black", linetype = "solid") +
  labs(x = "Chromosome Position",
       y = "SNP Density in variants/kb") +
  scale_x_continuous(labels = scales::label_number(suffix = "Mb", scale = 1e-6)
                    ) +
  theme_minimal(base_size = 15)

dist_U

# export
ggsave("genetic_polymorphism_U.png", plot = dist_U)

# males ----
## length ----
snpden_m |>
  group_by(CHROM) |>
  get_summary_stats(BIN_START, show = c("max"))


## dist ----
# distribution plots for all chromosomes
dist_m <- ggplot(snpden_m, aes(x = BIN_START, y = VARIANTS.KB, color = GROUP)) +
  geom_line() +
  geom_smooth(span = 0.1,se = FALSE, color = "black", linetype = "solid") +
  labs(x = "Chromosome Position",
       y = "SNP Density in variants/kb") +
  facet_wrap(~ CHROM) +
  scale_x_continuous(labels = scales::label_number(suffix = "Mb", scale = 1e-6)) +
  scale_color_manual(values = c("lightskyblue", "Dodgerblue"), guide = "none") +
  theme_minimal(base_size = 15)

dist_m

# export
ggsave("genetic_polymorphism_all_male.png", plot = dist_m)


# distribution plot for sex chromosome
dist_V <- snpden_m |>
  filter(CHROM == "chrV") |>
  ggplot(aes(x = BIN_START, y = VARIANTS.KB)) +
  geom_line(color = "Dodgerblue") +
  geom_smooth(span = 0.1,se = FALSE, color = "black", linetype = "solid") +
  labs(x = "Chromosome Position",
       y = "SNP Density in variants/kb") +
  scale_x_continuous(labels = scales::label_number(suffix = "Mb", scale = 1e-6)
  ) +
  theme_minimal(base_size = 15)

dist_V

# export
ggsave("genetic_polymorphism_V.png", plot = dist_V)

