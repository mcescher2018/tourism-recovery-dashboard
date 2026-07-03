# Lessons Learned

This project highlighted several practical challenges typical of real-world analytics work.

## Data Limitations

It is important to inspect raw data and adopt alternative approaches to validate results, regardless of the project specifications (see `preliminary_data_check.md` for further details).

In this case, the expected monthly granularity was not available in the dataset, and some categories were overlapping. As a result, additional filtering criteria and minor adjustments were required in the final implementation.

For example, the query in `01_stg_tourism.sql` includes the following constraints:

```sql
AND nace_r2 = 'I551-I553'   -- All accommodation types without overlaps
AND unit = 'NR'             -- Absolute values only (no percentage variations)
```

## Cross-OS Environment

The project was developed on Windows due to Power BI compatibility constraints and to maintain a single working environment.

File paths in `load_eurostat.py` were adapted from original Unix-style paths using Python’s `os.path` utilities to ensure cross-platform compatibility.

## DuckDB and Power BI Integration

Integrating DuckDB with Power BI required additional effort, particularly around ODBC driver configuration and data connectivity.

The custom [DuckDB Power Query Connector](https://github.com/motherduckdb/duckdb-power-query-connector) proved useful in enabling the connection.

However, some stability issues were observed. In particular, omitting optional fields in the connection configuration can lead to unexpected refresh errors. This was observed during development, though behavior may vary depending on the setup.