# ingest/load_eurostat.py
import os
import pandas as pd
import duckdb

# Build paths to work in Windows and Linux
base_dir = os.path.dirname(__file__)   
parent_dir = os.path.dirname(base_dir)    
tsv_path = os.path.join(parent_dir, "data", "raw", "tour_occ_arn2.tsv")
db_path = os.path.join(parent_dir, "data", "tourism.duckdb")

 # Eurostat marks missing as ":"
df = pd.read_csv(
    tsv_path,
    sep="\t",
    na_values=[":"],           
)

# Split the first column "freq,c_resid,unit,nace_r2,geo\TIME_PERIOD"
key_col = df.columns[0]
keys = df[key_col].str.split(",", expand=True)
keys.columns = key_col.split("\\")[0].split(",")
df = pd.concat([keys, df.drop(columns=[key_col])], axis=1)

# Wide → long
df_long = df.melt(
    id_vars=keys.columns.tolist(),
    var_name="period",
    value_name="nights",
)
df_long["nights"] = pd.to_numeric(df_long["nights"], errors="coerce")

con = duckdb.connect(db_path)
con.execute("CREATE OR REPLACE TABLE raw_eurostat AS SELECT * FROM df_long")
print(con.execute("SELECT COUNT(*) FROM raw_eurostat").fetchone())