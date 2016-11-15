{{
  config({
    "materialized" : "incremental",
    "sql_where" : "_sdc_received_at > (select max(_sdc_received_at) from {{this}})",
    "unique_key" : "id",
    "sort" : "created_at",
    })
}}

select u.id,
       first_name,
       last_name,
       u.email,
       verified_email,
       default_address_id,
       u.created_at,
       max(o._sdc_received_at) as _sdc_received_at,
       
--Calculated Columns
       count(o.id) as number_of_orders,
       min(o.created_at) as first_order_date,
       max(o.created_at) as last_order_date,
       datediff(second, min(o.created_at), max(o.created_at))::float / (60*60*24*365) as years_active,
       sum(o.subtotal_price) as lifetime_revenue
       

from {{ref('shopify_users')}} u 
join {{ref('shopify_orders')}} o on o.customer_id = u.id
group by 1,2,3,4,5,6,7