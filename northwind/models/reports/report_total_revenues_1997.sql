-- CONFIG
{{ config(
    schema='gold',
    materialized='table'
) }}

-- CTEs
with sources_orders as (
    select order_id, order_date
    from {{ ref('stg_orders') }}
),

sources_orders_details as (
    select *
    from {{ ref('stg_order_details') }}
),

filtered as (
    select order_id
    from sources_orders
    where extract(year from order_date) = 1997
),

business_rules as (
    select 
        sum(order_details.unit_price * order_details.quantity * (1.0 - order_details.discount)) as total_revenues_1997
    from sources_orders_details as order_details
    inner join filtered on filtered.order_id = order_details.order_id
)

-- QUERY FINAL
select * from business_rules
