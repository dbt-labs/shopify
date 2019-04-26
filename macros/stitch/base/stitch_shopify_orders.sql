{% macro stitch_shopify_orders() %}

    {{ adapter_macro('shopify.stitch_shopify_orders') }}

{% endmacro %}

{% macro default__stitch_shopify_orders() %}

    select 

        -- ids
        id as order_id,
        app_id,
        name as order_name,
        user_id,
        customer__id as customer_id,
        checkout_id,
        checkout_token,
        cart_token,
        token,
        
        -- customer attributes
        lower(email) as email,
        contact_email,
        buyer_accepts_marketing,
        confirmed,
        
        -- order attributes
        number as "number",
        order_number,
        currency,
        presentment_currency,
        financial_status,
        fulfillment_status,
        gateway,
        processing_method,
        total_tip_received,
        total_weight,
        total_discounts::decimal(38,6) * -1 as total_discounts_base,
        subtotal_price::decimal(38,6) as subtotal_price,
        total_line_items_price,
        total_price,
        total_price_usd,
        total_tax,
        total_shipping_price_set__presentment_money__amount::decimal(38,6) 
            as total_shipping_cost_base,
        total_shipping_price_set__presentment_money__currency_code::varchar 
            as shipping_currency_code,
        tags,
        taxes_included, --true/false
        order_status_url,
        
        --addresses
        location_id,
        nullif(shipping_address__city::varchar, '') as shipping_city,
        nullif(shipping_address__province::varchar, '') 
            as shipping_province,
        nullif(shipping_address__province_code::varchar, '') 
            as shipping_province_code,
        nullif(shipping_address__country::varchar, '') as shipping_country,
        nullif(shipping_address__country_code::varchar, '') 
            as shipping_country_code,
        nullif(shipping_address__zip::varchar, '') as shipping_zip_code,
        nullif(shipping_address__longitude, '') as shipping_longitude,
        nullif(shipping_address__latitude, '') as shipping_latitude,
        nullif(billing_address__city::varchar, '') as billing_city,
        nullif(billing_address__province::varchar, '') as billing_province,
        nullif(billing_address__province_code::varchar, '') 
            as billing_province_code,
        nullif(billing_address__country::varchar, '') as billing_country,
        nullif(billing_address__country_code::varchar, '') 
            as billing_country_code,
        nullif(billing_address__zip::varchar, '') as billing_zip_code,
        
        -- browser attributes
        referring_site,
        browser_ip,
        landing_site,
        source_name,
        
        -- dates
        created_at,
        processed_at,
        closed_at,
        cancelled_at,
        cancel_reason,
        updated_at
        
    from
      {{ var('orders_table') }}
    where test = false

{% endmacro %}


{% macro snowflake__stitch_shopify_orders() %}

    select 
    
        -- ids
        id as order_id,
        app_id,
        name as order_name,
        user_id,
        customer:id as customer_id,
        checkout_id,
        checkout_token,
        cart_token,
        token,
        
        -- customer attributes
        lower(email) as email,
        contact_email,
        buyer_accepts_marketing,
        confirmed,
        
        -- order attributes
        number as "number",
        order_number,
        currency,
        presentment_currency,
        financial_status,
        fulfillment_status,
        gateway,
        processing_method,
        total_tip_received,
        total_weight,
        total_discounts::number(38,6) * -1 as total_discounts_base,
        subtotal_price::number(38,6) as subtotal_price,
        total_line_items_price,
        total_price,
        total_price_usd,
        total_tax,
        total_shipping_price_set:presentment_money:amount::number(38,6) 
            as total_shipping_cost_base,
        total_shipping_price_set:presentment_money:currency_code::varchar 
            as shipping_currency_code,
        tags,
        taxes_included, --true/false
        order_status_url,
        
        --addresses
        location_id,
        nullif(shipping_address:city::varchar, '') as shipping_city,
        nullif(shipping_address:province::varchar, '') 
            as shipping_province,
        nullif(shipping_address:province_code::varchar, '') 
            as shipping_province_code,
        nullif(shipping_address:country::varchar, '') as shipping_country,
        nullif(shipping_address:country_code::varchar, '') 
            as shipping_country_code,
        nullif(shipping_address:zip::varchar, '') as shipping_zip_code,
        nullif(shipping_address:longitude, '') as shipping_longitude,
        nullif(shipping_address:latitude, '') as shipping_latitude,
        nullif(billing_address:city::varchar, '') as billing_city,
        nullif(billing_address:province::varchar, '') as billing_province,
        nullif(billing_address:province_code::varchar, '') 
            as billing_province_code,
        nullif(billing_address:country::varchar, '') as billing_country,
        nullif(billing_address:country_code::varchar, '') 
            as billing_country_code,
        nullif(billing_address:zip::varchar, '') as billing_zip_code,
        
        -- nested
        note,
        total_shipping_price_set,
        refunds,
        discount_codes,
        line_items,
        shipping_lines,
        
        -- browser attributes
        referring_site,
        browser_ip,
        landing_site,
        source_name,
        
        -- dates
        created_at,
        processed_at,
        closed_at,
        cancelled_at,
        cancel_reason,
        updated_at
        
    from
      {{ var('orders_table') }}
    where test = false

{% endmacro %}