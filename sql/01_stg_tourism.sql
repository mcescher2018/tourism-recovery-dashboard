CREATE OR REPLACE TABLE stg_tourism AS
SELECT
  geo                                AS nuts2_code,
  unit,
  c_resid                            AS residence,
  CAST(period AS INT)                AS year,
  nights
FROM raw_eurostat
WHERE 1=1
  AND geo LIKE 'IT%'              -- Italy only
  AND nights IS NOT NULL
  AND c_resid = 'TOTAL';          -- residents + non-residents combined