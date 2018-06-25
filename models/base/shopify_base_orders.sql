SELECT 

--IDs
       o.id,
       o.customer_id,
       o.order_number,

--Customer Info
       o.email,

--Order Status
       case source_name
              when 'web' then 'web'
              when '294517' then 'recharge'
              when 'Giftwizard' then 'giftwizard'
              else 'other'
       end as source,
       financial_status,
       fulfillment_status,
       processing_method,
       gateway,
       shipping_address_1,
       shipping_address_2,
       shipping_name,
       shipping_city,
       shipping_country,
       shipping_country_code,
       shipping_latitude,
       shipping_longitude,
       shipping_state,
       shipping_state_code,
       shipping_zip,
       shipping_price,

--Timestamps
       o.created_at,
       c.created_at as customer_created_at,
       greatest(o.updated_at, c.updated_at) as updated_at,
       cancelled_at,

--Calculated Columns
       rank() over (partition by o.customer_id order by o.created_at, o.id ASC) AS customer_order_number

FROM {{ref('shopify_source_orders')}} o
JOIN {{ref('shopify_base_customers')}} c on c.id = o.customer_id