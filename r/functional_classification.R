# Leeds Fungal Biodiversity - Functional Composition Analysis
# Phase 5: Classify fungi as mycorrhizal vs. saprotrophic

library(tidyverse)

# Load data
fungi <- read_csv("data/processed/leeds_fungi_clean.csv")

# Define functional groups by genus (based on ecological literature)
mycorrhizal_genera <- c(
  "Amanita", "Russula", "Lactarius", "Boletus", "Leccinum", 
  "Cortinarius", "Tricholoma", "Hebeloma", "Suillus", "Inocybe", 
  "Paxillus", "Cantharellus", "Hydnum", "Scleroderma", "Astraeus",
  "Rhizopogon", "Pisolithus", "Chroogomphus", "Gomphidius",
  "Laccaria", "Xerocomellus", "Clavulina"
)

saprotrophic_genera <- c(
  "Trametes", "Fomes", "Stereum", "Hypholoma", "Xylaria", 
  "Auricularia", "Fomitopsis", "Coprinus", "Mycena", "Psathyrella", 
  "Pluteus", "Clitocybe", "Marasmius", "Kuehneromyces", "Daedaleopsis",
  "Pholiota", "Stropharia", "Coprinellus", "Coprinopsis", "Panaeolus",
  "Agrocybe", "Gymnopilus", "Piptoporus", "Bjerkandera", "Ganoderma",
  "Pleurotus", "Schizophyllum", "Flammulina",
  "Hygrocybe", "Cuphophyllus", "Cerioporus", "Crepidotus", "Lycoperdon",
  "Collybiopsis", "Clavulinopsis", "Rhodocollybia", "Laetiporus", 
  "Gliophorus", "Daldinia", "Meripilus", "Calocera", "Exidia",
  "Lepista", "Ascocoryne", "Phlebia", "Dacrymyces", "Agaricus",
  "Apioperdon", "Entoloma", "Phallus", "Rickenella"
)

parasitic_genera <- c(
  "Armillaria", "Rhytisma", "Nectria", "Fistulina"
)

# Classify fungi
fungi_classified <- fungi %>%
  mutate(
    functional_group = case_when(
      genus %in% mycorrhizal_genera ~ "Mycorrhizal",
      genus %in% saprotrophic_genera ~ "Saprotrophic",
      genus %in% parasitic_genera ~ "Parasitic",
      TRUE ~ "Other/Unknown"
    )
  )

# Summary by functional group
cat("=== FUNCTIONAL GROUP CLASSIFICATION ===\n")
summary_table <- fungi_classified %>%
  count(functional_group) %>%
  mutate(percentage = round(n / sum(n) * 100, 1))

print(summary_table)

# Annual trends by functional group (ALL categories)
annual_functional <- fungi_classified %>%
  # Don't filter — keep all 3 categories
  count(year, functional_group) %>%
  group_by(year) %>%
  mutate(
    total = sum(n),
    proportion = n / total
  )

cat("\n=== ANNUAL PROPORTIONS ===\n")
print(annual_functional)

# Plot proportions over time
p1 <- ggplot(annual_functional, aes(x = year, y = proportion, 
                                     color = functional_group, 
                                     fill = functional_group)) +
  geom_area(alpha = 0.4, position = "fill") +
  geom_line(size = 1.2) +
  scale_color_manual(values = c("Mycorrhizal" = "#B794D9", 
                                "Saprotrophic" = "#7FAD87",
                                "Other/Unknown" = "#CCCCCC")) +
  scale_fill_manual(values = c("Mycorrhizal" = "#B794D9", 
                                "Saprotrophic" = "#7FAD87",
                                "Other/Unknown" = "#CCCCCC")) +
  scale_y_continuous(labels = scales::percent) +
  labs(
    title = "Mycorrhizal vs. Saprotrophic Fungi in Leeds (2009-2025)",
    subtitle = "Are tree-dependent fungi increasing over time?",
    x = "Year",
    y = "Proportion of Records",
    color = "Functional Group",
    fill = "Functional Group"
  ) +
  theme_minimal() +
  theme(
    legend.position = "bottom",
    plot.title = element_text(size = 16, face = "bold")
  )

ggsave("outputs/figures/functional_composition.png", p1, width = 10, height = 6, dpi = 300)
cat("\nSaved: outputs/figures/functional_composition.png\n")

# Statistical test: Is mycorrhizal proportion changing over time?
myco_only <- annual_functional %>%
  filter(functional_group == "Mycorrhizal") %>%
  filter(year >= 2009, year <= 2023)  # Exclude incomplete years

cor_test <- cor.test(myco_only$year, myco_only$proportion)

cat("\n=== MYCORRHIZAL TREND TEST ===\n")
cat("Correlation (mycorrhizal proportion vs. year):", 
    round(cor_test$estimate, 3), "\n")
cat("p-value:", round(cor_test$p.value, 3), "\n")

if (cor_test$p.value < 0.05) {
  if (cor_test$estimate > 0) {
    cat("✓ Mycorrhizal fungi ARE increasing significantly\n")
  } else {
    cat("✗ Mycorrhizal fungi are DECREASING significantly\n")
  }
} else {
  cat("✗ No significant trend\n")
}

# Save classified data
write_csv(fungi_classified, "data/processed/fungi_classified.csv")
cat("\nSaved: data/processed/fungi_classified.csv\n")

cat("\n=== ANALYSIS COMPLETE ===\n")