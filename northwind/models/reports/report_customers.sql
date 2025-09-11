-- models/reporting/clients_to_marketing.sql

{{ config(
    schema='silver',
    materialized='view'
) }}

select *
from {{ source('crm', 'raw_customers') }}
