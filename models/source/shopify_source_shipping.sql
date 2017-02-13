select id, sum(price) as shipping_price
from shopify.orders__shipping_lines
group by 1