
  
    

        create or replace transient table SNOWFLAKE_RND.silver.silver_plan_vaulation
         as
        (-- Silver plan valuation model deduplicating plan valuation history from ODS source
-- Co-authored with CoCo


WITH latest_record AS (

    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY
                PLAN_VALUATION_HISTORY_PLAN_ID,
                PLAN_VALUATION_HISTORY_DATE
            ORDER BY AUDIT_LAST_UPDATED_TIMESTAMP DESC
        ) AS RN

    FROM SNOWFLAKE_RND.ODS.PLAN_VALUATION_HISTORY_CDC

)

SELECT
    PLAN_VALUATION_HISTORY_PLAN_ID,
    PLAN_VALUATION_HISTORY_CLIENT_ID,
    PLAN_VALUATION_HISTORY_DATE,
    PLAN_VALUATION_HISTORY_VALUE

FROM latest_record

WHERE RN = 1
        );
      
  