CREATE OR REPLACE TABLE stg_tourism AS
SELECT
  geo                                AS nuts2_code,
  unit,
  c_resid                            AS residence,
  CAST(period AS INT)                AS year,
  nights                             AS arrivals
FROM raw_eurostat
WHERE 1=1
  AND geo LIKE 'IT%'            -- Italy only
  AND nace_r2 = 'I551-I553'		  -- All accomodations type with no overlappings
  AND c_resid = 'TOTAL'         -- residents + non-residents combined
  AND unit = 'NR'				        -- Only NR not percentage changes
  AND nights IS NOT NULL;