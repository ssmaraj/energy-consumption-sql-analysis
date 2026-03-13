# U.S. State Energy Consumption Analysis (2000–2020)
**SQL Portfolio Project | Data Source: U.S. Energy Information Administration (EIA)**

---

## Project Overview

This project analyzes 20 years of state-level energy consumption data using SQL. The analysis focuses on Texas and a set of peer states selected for their shared industrial energy profile and oil/gas production mix. Queries explore per-capita efficiency trends, year-over-year volatility, peer benchmarking, smoothed trend lines, and growth classification across all U.S. states.

**Tools:** PostgreSQL | **Data:** EIA State Energy Data System (SEDS)

---

## Peer State Methodology

Peer states were selected based on **industrial energy profile and oil/gas production mix**, not population size. States with comparable heavy industrial sectors, refining capacity, and fossil fuel production provide a more analytically meaningful benchmark for Texas than population-matched states would.

**Peer group:** TX, LA, OK, KS, WY, ND, AK

This approach mirrors how energy analysts and policy researchers benchmark state performance — prioritizing sector composition over demographic similarity.

---

## Queries

### Query 1 — 20-Year Per-Capita Efficiency Ranking
`query_1_efficiency_rank_20yr.sql`

Calculates total energy consumption per person (MMBtu/person) for every U.S. state across 20 years and ranks states by efficiency within each year using a window function.

**Techniques:** CTE, JOIN, CASE/WHEN unpivot, `RANK()` window function, calculated field

---

### Query 2 — Year-Over-Year Consumption Change (Texas)
`query_2_yoy_change.sql`

Computes annual percent change in residential, commercial, and industrial energy consumption for Texas using `LAG()`. Uses `unnest()` to unpivot wide-format data into a clean time series before applying window logic.

**Techniques:** Subquery, `unnest()` array unpivot, `LAG()` window function, `NULLIF()` for divide-by-zero protection

---

### Query 3 — Peer State Industrial Consumption Benchmarking
`query_3_peer_comparison.sql`

Compares Texas industrial energy consumption per capita against the peer state group average for each year. Produces a variance column (`vs_peer_avg`) showing how far Texas deviates from the peer mean in any given year.

**Techniques:** CTE, JOIN, window `AVG()` with `PARTITION BY`, calculated deviation field, peer group filtering

---

### Query 4 — 5-Year Rolling Average by Sector (Texas)
`query_4_rolling_average.sql`

Smooths Texas energy consumption trends across residential, commercial, and industrial sectors using a 5-year rolling window. Useful for identifying long-term directional trends while filtering out year-to-year noise.

**Techniques:** CTE, JOIN, `AVG() OVER (ROWS BETWEEN 4 PRECEDING AND CURRENT ROW)` rolling window

---

### Query 5 — State Growth Category Classification (2000 vs. 2020)
`query_5_growth_categories.sql`

Compares each state's total energy consumption in 2000 vs. 2020, calculates absolute and percent change, and classifies states as **High Growth**, **Stable**, or **Declining** using threshold-based `CASE` logic (±15%).

**Techniques:** CTE, calculated fields, `NULLIF()`, conditional `CASE` classification

---

## Key SQL Concepts Demonstrated

| Concept | Queries |
|---|---|
| CTEs (WITH clause) | 1, 3, 4, 5 |
| Window functions (`RANK`, `LAG`, `AVG OVER`) | 1, 2, 3, 4 |
| Wide-to-long unpivoting (`CASE/WHEN`, `unnest`) | 1, 2, 3, 4 |
| Divide-by-zero protection (`NULLIF`) | 2, 5 |
| Conditional classification (`CASE`) | 1, 5 |
| Multi-table JOIN | 1, 3, 4 |
| Subqueries | 2 |

---

## Data Notes

- **Source:** EIA State Energy Data System (SEDS)
- **MSN codes used:**
  - `TETCB` — Total energy consumption, all sectors
  - `TERCB` — Residential sector consumption
  - `TECCB` — Commercial sector consumption
  - `TEICB` — Industrial sector consumption
- **Unit:** Billion BTU (converted to MMBtu per capita where noted)
- **Coverage:** All 50 U.S. states, 2000–2020

---

## About

Shanta | Data Analytics | Houston, TX  
[LinkedIn](#) · [Portfolio](#)
