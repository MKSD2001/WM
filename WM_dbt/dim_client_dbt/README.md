# dim_client_dbt

DIM_CLIENT (SCD Type 2) pipeline for Wren Sterling-style client dimension data, built
with dbt Core, runnable either as **dbt Projects on Snowflake** (native) or via the
standard dbt CLI.

## Layers
- `models/staging/` — Bronze: light clean/cast over `RAW.SRC_CLIENT`
- `models/silver/` — Silver: dedup + change-hash (`row_hash`)
- `snapshots/` — SCD2 history via dbt snapshot (`strategy: check` on `row_hash`)
- `models/gold/` — Gold: `dim_client` with surrogate key `client_sk` and `is_current_flag`

## Setup
```bash
dbt deps
dbt build
```

## Run order (if not using `dbt build`)
```bash
dbt run --select stg_client silver_client
dbt snapshot
dbt run --select dim_client
dbt test --select dim_client
```

## Deploying to Snowflake natively (dbt Projects on Snowflake)
Push this repo, connect it to a Snowsight Workspace ("Create Workspace → From Git
repository"), then **Connect → Deploy dbt project** to create the `DBT PROJECT` object.
