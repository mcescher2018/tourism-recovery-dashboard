WITH yearly AS (
  SELECT region_name, year, SUM(arrivals) AS yearly_arrivals
  FROM   fct_yearly_arrivals
  GROUP BY region_name, year
),
pivoted AS (
  SELECT
    region_name,
	  SUM(CASE WHEN year = 2019 THEN yearly_arrivals END) AS arrivals_2019,
    SUM(CASE WHEN year = 2021 THEN yearly_arrivals END) AS arrivals_2021,
    SUM(CASE WHEN year = 2023 THEN yearly_arrivals END) AS arrivals_2023,
    SUM(CASE WHEN year = 2025 THEN yearly_arrivals END) AS arrivals_2025
  FROM yearly
  GROUP BY region_name
)
SELECT
  region_name,
  arrivals_2019,
  arrivals_2021,
  arrivals_2023,
  arrivals_2025,
  ROUND(arrivals_2021 / arrivals_2019, 3) AS recovery_2021,
  ROUND(arrivals_2023 / arrivals_2019, 3) AS recovery_2023,
  ROUND(arrivals_2025 / arrivals_2019, 3) AS recovery_2025,
  ROUND((arrivals_2025 - arrivals_2021) / arrivals_2019, 3) AS lift_21_to_25
FROM pivoted
ORDER BY recovery_2025 DESC NULLS LAST;