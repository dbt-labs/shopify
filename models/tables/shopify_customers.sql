select u.id,
       first_name,
       last_name,
       u.email,
       verified_email,
       default_address_id,
       u.created_at,
       
--Calculated Columns
       count(o.id) as number_of_orders,
       min(o.created_at) as first_order_date,
       max(o.created_at) as last_order_date,
       max(o.created_at) - min(o.created_at) as years_active,
       sum(o.subtotal_price) as lifetime_revenue
       

from {{ref('shopify_users')}} u 
join {{ref('shopify_orders')}} o on o.customer_id = u.id
group by 1,2,3,4,5,6,7