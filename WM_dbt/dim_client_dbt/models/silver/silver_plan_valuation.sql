-- Silver plan valuation model deduplicating plan valuation history from ODS source
-- Co-authored with CoCo
{{ config(
    materialized='table'
) }}

WITH latest_record AS (

    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY
                PLAN_VALUATION_HISTORY_PLAN_ID,
                PLAN_VALUATION_HISTORY_DATE
            ORDER BY AUDIT_LAST_UPDATED_TIMESTAMP DESC
        ) AS RN

    FROM {{ source('ods','ods_planval') }}

)

SELECT
    PLAN_VALUATION_HISTORY_PLAN_ID,
    PLAN_VALUATION_HISTORY_CLIENT_ID,
    PLAN_VALUATION_HISTORY_DATE,
    PLAN_VALUATION_HISTORY_VALUE

FROM latest_record

WHERE RN = 1