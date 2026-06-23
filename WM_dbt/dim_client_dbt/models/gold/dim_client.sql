-- Gold layer: final DIM_CLIENT with surrogate key + current-row flag
select
    {{ dbt_utils.generate_surrogate_key(['client_id', 'dbt_valid_from']) }} as client_sk,
    client_id,
    client_name,
    client_type,
    region,
    risk_profile,
    status,
    source_system,
    dbt_valid_from                                       as effective_start_date,
    coalesce(dbt_valid_to, '9999-12-31'::timestamp_ntz)   as effective_end_date,
    case when dbt_valid_to is null then 'Y' else 'N' end  as is_current_flag
from {{ ref('dim_client_snapshot') }}
