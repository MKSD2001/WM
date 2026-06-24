
  
    

        create or replace transient table SNOWFLAKE_RND.gold.dim_date
         as
        (

WITH date_spine AS (

    SELECT
        DATEADD(
            DAY,
            SEQ4(),
            '2020-01-01'::DATE
        ) AS DATE_VALUE

    FROM TABLE(
        GENERATOR(ROWCOUNT => 36525)
    )

)

SELECT

    TO_NUMBER(
        TO_CHAR(DATE_VALUE,'YYYYMMDD')
    ) AS DATE_KEY,

    DATE_VALUE,

    YEAR(DATE_VALUE)           AS YEAR,

    QUARTER(DATE_VALUE)        AS QUARTER,

    MONTH(DATE_VALUE)          AS MONTH,

    MONTHNAME(DATE_VALUE)      AS MONTH_NAME,

    DAY(DATE_VALUE)            AS DAY_OF_MONTH,

    DAYOFWEEK(DATE_VALUE)      AS DAY_OF_WEEK,

    DAYNAME(DATE_VALUE)        AS DAY_NAME,

    WEEK(DATE_VALUE)           AS WEEK_NUMBER,

    CASE
        WHEN DAYOFWEEK(DATE_VALUE) IN (0,6)
        THEN 'Y'
        ELSE 'N'
    END AS WEEKEND_FLAG,

    DATE_TRUNC('MONTH', DATE_VALUE)
        AS MONTH_START_DATE,

    LAST_DAY(DATE_VALUE)
        AS MONTH_END_DATE,

    DATE_TRUNC('QUARTER', DATE_VALUE)
        AS QUARTER_START_DATE,

    DATE_TRUNC('YEAR', DATE_VALUE)
        AS YEAR_START_DATE

FROM date_spine
        );
      
  