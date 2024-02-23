{{ config(materialized='table') }}

SELECT
  "bill/BillingPeriodStartDate",
  "bill/PayerAccountId",
  "lineItem/UsageAccountId",
  "lineItem/ProductCode",
  "lineItem/UsageType",
  "lineItem/Operation",
  "lineItem/UsageStartDate",
  "lineItem/UsageEndDate",
  "lineItem/ResourceId",
  CURRENT_DATE,
  CAST("lineItem/UsageStartDate" AS TIMESTAMP)::date AS startDate,
  CONCAT(
    "bill/BillingPeriodStartDate", '-',
    "bill/PayerAccountId", '-',
    "lineItem/UsageAccountId", '-',
    "lineItem/ProductCode", '-',
    "lineItem/UsageType", '-',
    "lineItem/Operation", '-',
    "lineItem/UsageStartDate", '-',
    "lineItem/UsageEndDate", '-',
    "lineItem/ResourceId"
  ) AS "UniqueIdentifier"
FROM
  "public"."staging_feb"
WHERE 
    CAST("lineItem/UsageStartDate" AS TIMESTAMP)::date = CURRENT_DATE
