{% snapshot dim_client_snapshot %}

{{
config(
schema='gold',
unique_key='CLIENT_ID',
strategy='check',
check_cols=['ROW_HASH'],
invalidate_hard_deletes=True
)
}}

SELECT
CLIENT_ID,
CLIENT_FULL_NAME,
CLIENT_FIRST_NAME,
CLIENT_GENDER,
CLIENT_DATE_OF_BRITH,
CLIENT_DEFAULT_EMAIL,
CLIENT_DEFAULT_MOBILE,
CLIENT_COUNTRY_OF_RESIDENCE,
CLIENT_COMPANY_NAME,
CLIENT_COMPANY_TYPE,
CDC_TIMESTAMP,
ROW_HASH
FROM {{ ref('silver_client') }}

{% endsnapshot %}
