# Leeds Fungal Biodiversity Recovery

**Time-series analysis of fungal biodiversity trends in Leeds (2009-2025) and correlation with citywide restoration initiatives**

## Project Overview

This project investigates whether fungal biodiversity in Leeds has increased between 2009-2025 and whether temporal patterns correlate with the timing of urban tree planting and restoration programmes (White Rose Forest, Northern Forest partnership, brownfield redevelopment).

Using 10,200 GBIF fungal occurrence records, I analyse species richness trends, functional composition changes (mycorrhizal vs. saprotrophic fungi), and identify indicator species of ecological recovery.

**Research Questions:**
1. Has fungal species richness in Leeds increased between 2009-2025?
2. Do biodiversity increases correlate with major tree planting initiatives?
3. Are mycorrhizal fungi (tree-dependent) increasing relative to saprotrophic fungi (deadwood decomposers)?
4. Which fungal species are early indicators of ecological recovery?

**This is a citywide temporal study, not site-level analysis.** Due to coordinate uncertainty in 86% of GBIF records (>1km precision), spatial matching to individual brownfield sites is not feasible. Instead, the project examines Leeds-wide biodiversity trends and their relationship to restoration timeline events.

## Project Evolution

**This project began with a different scope and adapted based on data quality findings.**

**Original plan:** Site-level analysis comparing fungal biodiversity recovery at restored vs. unrestored brownfield sites.

**Why the scope changed:** Data quality assessment (Phase 1-2) revealed that 86% of GBIF fungal records have coordinate uncertainty >1km, preventing reliable spatial matching to individual brownfield sites (878 sites, mean area ~1 hectare). Only 10.4% of records met the <100m precision threshold required for site-level analysis.

**Revised approach:** Citywide temporal analysis examining whether Leeds' fungal biodiversity increased 2009-2025 and whether trends correlate with restoration initiatives. This approach:
- Uses the full dataset (10,200 records) rather than discarding 90%
- Addresses meaningful ecological questions about urban biodiversity recovery
- Acknowledges coordinate uncertainty limitations while working within them

**Key lesson:** Citizen science data (GBIF) is valuable for broad temporal/regional trends but unsuitable for fine-scale spatial analysis without quality filtering. Future site-level studies would require systematic plot surveys with <50m GPS precision.

## Study Area

**Leeds, UK** — registered brownfield sites from the UK Brownfield Land Register, filtered to those with:
- Known restoration history (restored with dates, or confirmed unrestored)
- GBIF fungal occurrence records (2009-2025)
- Control sites: nearby parks/woodlands that were never brownfield (ancient woodland, established parks)

**Why Leeds:**
- Single unitary authority (cleaner restoration records than multi-borough regions)
- Active restoration initiatives (White Rose Forest, Northern Forest partnership)
- Strong NGO presence (Groundwork Leeds, Yorkshire Wildlife Trust)
- Well-documented tree planting schemes supporting fungal recovery

## Data Sources

- **Brownfield sites:** UK Brownfield Land Register (Leeds City Council)
- **Fungal occurrence records:** GBIF API (species observations with coordinates + dates)
- **Restoration records:** Leeds City Council planning portal, Groundwork Leeds project reports, White Rose Forest planting records
- **Land cover validation:** Google Earth historical imagery (confirm restoration timing)
- **Control sites:** OS MasterMap greenspaces (ancient woodland, established parks)

## Methodology

### Phase 1: Data Collection ✅
- [x] Downloaded Leeds brownfield register (878 sites)
- [x] Queried GBIF API for fungal occurrence records in Leeds (10,200 records, 1,107 species, 2009-2025)
- [x] Assessed data quality (86% coordinate uncertainty >1km)

### Phase 2: Data Cleaning ✅
- [x] Removed duplicates (same species, location, year)
- [x] Filtered to species-level identifications
- [x] Created annual time-series dataset (8,548 records)

### Phase 3: Temporal Analysis (R)
- [ ] Plot species accumulation curves (2009-2025)
- [ ] Calculate Shannon diversity index annually
- [ ] Test for temporal trends (linear regression, GAM)
- [ ] Account for recording effort bias (rarefaction analysis)

### Phase 4: Restoration Timeline Correlation
- [ ] Compile Leeds restoration events (tree planting numbers, brownfield projects, dates)
- [ ] Lag correlation analysis (2-year, 5-year lags)
- [ ] Statistical test: do diversity spikes follow restoration events?

### Phase 5: Functional Composition Analysis
- [ ] Classify fungi by ecological function (mycorrhizal vs. saprotrophic)
- [ ] Test whether mycorrhizal fungi are increasing (indicates tree establishment)
- [ ] Identify indicator species (early colonisers vs. late-successional)

### Phase 6: Outputs
- [ ] Time-series visualisations (ggplot2)
- [ ] Interactive map showing recording locations (Folium)
- [ ] Technical write-up (portfolio page)
- [ ] Stakeholder brief (restoration practitioners)

## Expected Outputs

**Visualisations:**
- Time-series plots (species richness over time, by site category)
- Species accumulation curves
- Indicator species analysis (which fungi appear first after restoration)
- Interactive map of recording effort distribution

**Deliverables:**
- Technical write-up (portfolio page)
- Restoration practitioner guide (stakeholder PDF)
- Interactive web map
- Code repository (R + Python scripts)

## Technologies

**Data Collection:** GBIF API (Python), web scraping (restoration records)  
**Analysis:** R (biodiversity metrics, time-series, ggplot2), Python (data cleaning, spatial joins)  
**Visualisation:** ggplot2, matplotlib, seaborn, Folium (interactive maps)  
**Geospatial:** GeoPandas, sf, QGIS

## Key Literature

- Sheldrake, M. (2020). *Entangled Life: How Fungi Make Our Worlds*
- Stamets, P. (2005). *Mycelium Running: How Mushrooms Can Help Save the World*
- Dickie, I. A. et al. (2013). "Ecosystem service and biodiversity trade-offs in woody successions"
- Teste, F. P. et al. (2017). "Plant-soil feedback and the maintenance of diversity in Mediterranean-climate shrublands"

## Data & Code

**Completed phases:**
- Phase 1: Data collection (878 brownfield sites, 10,200 fungal records)
- Phase 2: Data cleaning (8,548 cleaned records)

**Available datasets:**
- `data/raw/leeds_brownfield.csv` — 878 brownfield sites (filtered from UK register)
- `data/gbif/leeds_fungi_raw.csv` — 10,200 GBIF fungal occurrence records
- `data/processed/leeds_fungi_clean.csv` — 8,548 cleaned records (deduplicated)
- `data/processed/annual_species_richness.csv` — Species richness 2009-2025

**Code:**
- `python/gbif_download.py` — GBIF API query script
- `python/gbif_clean.py` — Data cleaning and deduplication

## Timeline

**Month 3:**
- Phase 3: Temporal analysis (R)
- Phase 4: Restoration timeline correlation

**Month 4:**
- Phase 5: Functional composition analysis
- Phase 6: Outputs and portfolio write-up

## License

MIT License

## Contact

Daniel Crompton | [LinkedIn](https://www.linkedin.com/in/dtcrompton/) | [Portfolio](https://dtcrompton.github.io)