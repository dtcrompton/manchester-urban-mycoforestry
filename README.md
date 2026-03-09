# Leeds Brownfield Fungal Biodiversity Recovery

**Time-series analysis of fungal species richness and community composition at restored vs. unrestored brownfield sites using GBIF occurrence records**

## Project Overview

This project investigates whether — and how quickly — fungal biodiversity recovers after brownfield restoration interventions. Using GBIF (Global Biodiversity Information Facility) occurrence records from 2000-2025, I compare fungal species richness trajectories at restored brownfield sites, unrestored sites, and never-brownfield control locations in Leeds.

**Research Questions:**
1. Does fungal species richness increase after brownfield restoration?
2. How long does recovery take? (5 years? 10? 20?)
3. Which fungal species are early colonisers vs. late-successional?
4. Does restoration method (passive rewilding vs. active tree planting) affect recovery rates?

## Study Area

**Leeds, UK** — registered brownfield sites from the UK Brownfield Land Register, filtered to those with:
- Known restoration history (restored with dates, or confirmed unrestored)
- GBIF fungal occurrence records (2000-2025)
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

### Phase 1: Data Collection
- [ ] Download Leeds brownfield register
- [ ] Query GBIF API for fungal occurrence records in Leeds (2000-2025)
- [ ] Identify restored sites (council records, planning applications, NGO reports)
- [ ] Record restoration dates and methods (tree planting, soil remediation, passive rewilding)
- [ ] Select control sites (never-brownfield green spaces)

### Phase 2: Data Processing
- [ ] Clean GBIF data (remove duplicates, verify coordinates, check taxonomy)
- [ ] Spatial join: match fungal records to brownfield sites
- [ ] Categorise sites: restored (with dates), unrestored, control
- [ ] Create time-series dataset (site × year × species richness)

### Phase 3: Biodiversity Metrics
- [ ] Calculate species richness over time (rolling windows)
- [ ] Compute Shannon diversity index, evenness
- [ ] Identify indicator species (early vs. late colonisers)
- [ ] Compare mycorrhizal vs. saprotrophic fungi recovery

### Phase 4: Time-Series Analysis (R)
- [ ] Plot species accumulation curves (restored vs. unrestored)
- [ ] Statistical comparison (t-tests, ANOVA for recovery rates)
- [ ] Regression models: time since restoration → species richness
- [ ] Identify tipping points (when does richness accelerate?)

### Phase 5: Spatial Analysis (QGIS + Python)
- [ ] Map fungal hotspots (which sites recovered fastest?)
- [ ] Correlate recovery with site characteristics (size, soil type, connectivity to woodlands)
- [ ] Create interactive map showing recovery trajectories

### Phase 6: Stakeholder Outputs
- [ ] Findings summary for restoration practitioners
- [ ] Species guides: "Plant these trees to accelerate fungal recovery"
- [ ] Portfolio write-up with visualisations
- [ ] Interactive dashboard

## Expected Outputs

**Visualisations:**
- Time-series plots (species richness over time, by site category)
- Species accumulation curves
- Indicator species analysis (which fungi appear first after restoration)
- Interactive map of recovery hotspots

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
- Dickie, I. A. et al. (2013). "Ecosystem service and biodiversity trade-offs in two woody successions"
- Teste, F. P. et al. (2017). "Plant-soil feedback and the maintenance of diversity in Mediterranean-climate shrublands"

## Timeline

**Month 5:**
- Phase 1-2: Data collection + processing
- Phase 3: Biodiversity metrics

**Month 6:**
- Phase 4-5: Time-series analysis + spatial mapping
- Phase 6: Portfolio write-up + stakeholder outputs

## License

MIT License

## Contact

Daniel Crompton | [LinkedIn](https://www.linkedin.com/in/dtcrompton/) | [Portfolio](https://dtcrompton.github.io)