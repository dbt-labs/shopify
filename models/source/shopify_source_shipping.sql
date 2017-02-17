select _sdc_source_key_id as id, sum(price) as shipping_price, max(_sdc_received_at) as updated_at
from shopify.orders__shipping_lines
group by 1