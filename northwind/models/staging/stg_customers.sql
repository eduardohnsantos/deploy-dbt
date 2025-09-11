{{ config(
    schema='silver',
    materialized='view'
) }}

select
    customer_id,
    company_name
from {{ ref('raw_customers') }}
