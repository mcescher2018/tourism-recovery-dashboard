WITH yearly AS (
  SELECT region_name, year, SUM(nights) AS yearly_nights
  FROM   fct_yearly_nights
  GROUP BY region_name, year
),
pivoted AS (
  SELECT
    region_name,
	SUM(CASE WHEN year = 2019 THEN yearly_nights END) AS nights_2019,
    SUM(CASE WHEN year = 2021 THEN yearly_nights END) AS nights_2021,
    SUM(CASE WHEN year = 2023 THEN yearly_nights END) AS nights_2023,
    SUM(CASE WHEN year = 2025 THEN yearly_nights END) AS nights_2025
  FROM yearly
  GROUP BY region_name
)
SELECT
  region_name,
  nights_2019,
  nights_2021,
  nights_2023,
  nights_2025,
  ROUND(nights_2021 / nights_2019, 3) AS recovery_2021,
  ROUND(nights_2023 / nights_2021, 3) AS recovery_2023,
  ROUND(nights_2025 / nights_2023, 3) AS recovery_2025,
  ROUND((nights_2025 - nights_2021) / nights_2019, 3) AS lift_21_to_25
FROM pivoted
ORDER BY recovery_2025 DESC NULLS LAST;