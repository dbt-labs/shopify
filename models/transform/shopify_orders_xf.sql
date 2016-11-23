with orders as (

  select * from {{ref('shopify_orders')}}

)

select
  *,
  row_number() over (partition by customer_id order by created_at) as order_seq_number
from orders
