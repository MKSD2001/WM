-- Bronze layer: light clean/cast, 1:1 with source, no business logic
with source as (
    select * from SNOWFLAKE_RND.SOURCE.CLIENT_CDC
)

select
    CLIENT_ID ,
	CLIENT_FULL_NAME ,
	CLIENT_FIRST_NAME ,
	CLIENT_GENDER ,
	CLIENT_DATE_OF_BRITH ,
	CLIENT_DEFAULT_EMAIL ,
	CLIENT_DEFAULT_MOBILE ,
	CLIENT_COUNTRY_OF_RESIDENCE,
	CLIENT_COMPANY_NAME,
	CLIENT_COMPANY_TYPE,
	CDC_ACTION ,
	CDC_TIMESTAMP 
from source
where client_id is not null