select id as order_item_id, order_id, customer_id
from {{ref('shopify_source_order_items')}}
where title not like '%Gift Subscription%' and (title like '%Subscription%' or title like '%Auto renew%')