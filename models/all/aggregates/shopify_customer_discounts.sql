select customer_id,
listagg(code || ' x' || times_used, ', ') within group (order by times_used desc) as codes_used
from(
select
  customer_id,
  code,
  count(code) as times_used
  from {{ref('shopify_source_discount_codes')}} dc
  join {{ref('shopify_base_orders')}} o on o.id = dc.order_id
group by 1,2
)
group by 1