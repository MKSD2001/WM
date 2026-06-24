{% snapshot dim_plan_snapshot %}

{{
config(
schema='gold',
unique_key='PLAN_ID',
strategy='check',
check_cols=['ROW_HASH'],
invalidate_hard_deletes=True
)
}}

SELECT
  PLAN_ID
, PLAN_CATEGORY_NAME
, PLAN_CLIENT_CATEGORY
, PLAN_END_DATE
, PLAN_POLICY_NUMBER
, PLAN_PRODUCT_TYPE
, PLAN_PROVIDER_NAME
, PLAN_SELLING_ADVISER_FULL_NAME
, PLAN_SERVICING_ADVISER_FULL_NAME
, PLAN_START_DATE
, PLAN_STATUS
, CDC_TIMESTAMP
, ROW_HASH
FROM {{ ref('silver_plan') }}

{% endsnapshot %}
