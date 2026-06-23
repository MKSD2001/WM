-- Silver layer: dedup per client_id, build a row_hash for SCD2 change detection
with deduped as (
    select
        *,
        row_number() over (
            partition by client_id
            order by load_ts desc
        ) as rn
    from {{ ref('stg_client') }}
)

select
    client_id,
    client_name,
    client_type,
    region,
    risk_profile,
    status,
    source_system,
    load_ts,
    {{ dbt_utils.generate_surrogate_key([
        'client_name', 'client_type', 'region', 'risk_profile', 'status'
    ]) }} as row_hash
from deduped
where rn = 1
