{% snapshot dim_client_snapshot %}

{{
    config(
        target_schema='gold',
        unique_key='client_id',
        strategy='check',
        check_cols=['row_hash'],
        invalidate_hard_deletes=True
    )
}}

select * from {{ ref('silver_client') }}

{% endsnapshot %}
