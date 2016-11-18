select 

order_id,
--Calculated Column

sum(quantity) as count_of_items

from {{ref('shopify_base_order_items')}}
group by 1