-- Bronze layer: light clean/cast, 1:1 with source, no business logic
with source as (
    select * from SNOWFLAKE_RND.RAW.SRC_CLIENT
)

select
    trim(client_id)             as client_id,
    trim(client_name)           as client_name,
    upper(trim(client_type))    as client_type,
    trim(region)                as region,
    initcap(trim(risk_profile)) as risk_profile,
    initcap(trim(status))       as status,
    source_system,
    load_ts
from source
where client_id is not null