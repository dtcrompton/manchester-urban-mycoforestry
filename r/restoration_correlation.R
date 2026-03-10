# Leeds Fungal Biodiversity - Restoration Correlation Analysis
# Phase 4: Test if fungal diversity responds to tree planting events

library(tidyverse)
library(ggplot2)

# Load data
rarefied <- read_csv("data/processed/rarefied_richness.csv")
shannon <- read_csv("data/processed/shannon_diversity.csv")
restoration <- read_csv("data/raw/leeds_restoration_timeline.csv")

# Merge datasets
combined <- rarefied %>%
  left_join(shannon, by = "year") %>%
  left_join(restoration, by = "year")

print(combined)

# ============================================================
# VISUAL CORRELATION: DUAL-AXIS PLOT
# ============================================================

# Normalize for dual-axis plotting
combined <- combined %>%
  mutate(
    richness_scaled = (rarefied_richness - min(rarefied_richness, na.rm=TRUE)) / 
                      (max(rarefied_richness, na.rm=TRUE) - min(rarefied_richness, na.rm=TRUE)),
    trees_scaled = (trees_planted - min(trees_planted, na.rm=TRUE)) / 
                   (max(trees_planted, na.rm=TRUE) - min(trees_planted, na.rm=TRUE))
  )

# Plot trees planted vs fungal richness
p1 <- ggplot(combined, aes(x = year)) +
  geom_col(aes(y = trees_planted / 1000), fill = "#7FAD87", alpha = 0.6) +
  geom_line(aes(y = rarefied_richness * 1.5), color = "#B794D9", size = 1.2) +
  geom_point(aes(y = rarefied_richness * 1.5), color = "#B794D9", size = 3) +
  scale_y_continuous(
    name = "Rarefied Species Richness",
    sec.axis = sec_axis(~./1.5, name = "Trees Planted (thousands)")
  ) +
  labs(
    title = "Tree Planting vs. Fungal Species Richness in Leeds",
    subtitle = "Does fungal diversity increase after tree planting events?",
    x = "Year"
  ) +
  theme_minimal() +
  theme(
    axis.title.y.left = element_text(color = "#B794D9", face = "bold"),
    axis.title.y.right = element_text(color = "#7FAD87", face = "bold"),
    plot.title = element_text(size = 16, face = "bold")
  )

ggsave("outputs/figures/restoration_correlation.png", p1, width = 12, height = 6, dpi = 300)
cat("Saved: outputs/figures/restoration_correlation.png\n\n")

# ============================================================
# LAG CORRELATION ANALYSIS
# ============================================================

cat("=== LAG CORRELATION ANALYSIS ===\n")
cat("Testing if fungal diversity responds 2-5 years after planting\n\n")

# Create lagged tree planting variables
combined <- combined %>%
  arrange(year) %>%
  mutate(
    trees_lag2 = lag(trees_planted, 2),  # 2 years ago
    trees_lag3 = lag(trees_planted, 3),  # 3 years ago
    trees_lag5 = lag(trees_planted, 5)   # 5 years ago
  )

# Correlation tests (only for years with data)
valid_data <- combined %>% filter(year >= 2009, year <= 2023)

# Test correlation between richness and tree planting (contemporaneous)
cor_current <- cor.test(valid_data$rarefied_richness, valid_data$trees_planted, 
                        use = "complete.obs")
cat("Correlation (same year):", round(cor_current$estimate, 3), 
    "p-value:", round(cor_current$p.value, 3), "\n")

# Test 2-year lag
cor_lag2 <- cor.test(valid_data$rarefied_richness, valid_data$trees_lag2, 
                     use = "complete.obs")
cat("Correlation (2-year lag):", round(cor_lag2$estimate, 3), 
    "p-value:", round(cor_lag2$p.value, 3), "\n")

# Test 3-year lag
cor_lag3 <- cor.test(valid_data$rarefied_richness, valid_data$trees_lag3, 
                     use = "complete.obs")
cat("Correlation (3-year lag):", round(cor_lag3$estimate, 3), 
    "p-value:", round(cor_lag3$p.value, 3), "\n")

# Test 5-year lag
cor_lag5 <- cor.test(valid_data$rarefied_richness, valid_data$trees_lag5, 
                     use = "complete.obs")
cat("Correlation (5-year lag):", round(cor_lag5$estimate, 3), 
    "p-value:", round(cor_lag5$p.value, 3), "\n\n")

# ============================================================
# BEFORE/AFTER COMPARISON
# ============================================================

cat("=== BEFORE/AFTER MAJOR PLANTING (2020) ===\n")

before <- valid_data %>% filter(year < 2020) %>% pull(rarefied_richness)
after <- valid_data %>% filter(year >= 2020) %>% pull(rarefied_richness)

cat("Mean richness before 2020:", round(mean(before, na.rm=TRUE), 1), "\n")
cat("Mean richness 2020-2023:", round(mean(after, na.rm=TRUE), 1), "\n")

t_test <- t.test(after, before)
cat("t-test p-value:", round(t_test$p.value, 3), "\n\n")

if (t_test$p.value < 0.05) {
  cat("✓ Significant difference!\n")
} else {
  cat("✗ No significant difference\n")
}

cat("\n=== ANALYSIS COMPLETE ===\n")