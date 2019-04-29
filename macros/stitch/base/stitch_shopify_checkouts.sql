{% macro stitch_shopify_checkouts() %}

    {{ adapter_macro('shopify.stitch_shopify_checkouts') }}

{% endmacro %}

{% macro default__stitch_shopify_checkouts() %}
    
    select
    
        --ids
        id as checkout_id,
        customer__id as customer_id,
        nullif(lower(email), '') as email,
        nullif(cart_token, '') as cart_token,
        nullif(token, '') as token,
        
        --fields 
        abandoned_checkout_url,
        name,
        completed_at,
        currency,
        gateway,
        landing_site,
        source_name,
        referring_site,
        subtotal_price,
        taxes_included,
        total_discounts,
        total_line_items_price,
        total_price,
        total_tax,
        total_weight,
        
        --address fields
        
        {{ stitch_shopify_billing_fields() }}
        
        {{ stitch_shopify_shipping_fields() }}
                
        --dates        
        updated_at,
        created_at
        
    from
        {{ var('checkouts_table') }}
    

{% endmacro %}


{% macro snowflake__stitch_shopify_checkouts() %}

    select
        id as checkout_id,
        customer:id as customer_id,
        nullif(lower(email), '') as email,
        nullif(cart_token, '') as cart_token,
        nullif(token, '') as token,
        abandoned_checkout_url,
        name,
        completed_at,
        currency,
        gateway,
        landing_site,
        source_name,
        referring_site,
        subtotal_price,
        taxes_included,
        total_discounts,
        total_line_items_price,
        total_price,
        total_tax,
        total_weight,
        
        nullif(billing_address:address1::varchar(256), '') 
            as billing_address_address1,
        nullif(billing_address:address1::varchar(256), '') 
            as billing_address_address2,
        nullif(billing_address:city::varchar(256), '') as billing_city,
        nullif(billing_address:company::varchar(256), '') 
            as billing_company,
        nullif(billing_address:country::varchar(256), '') 
            as billing_country,
        nullif(billing_address:country_code::varchar(256), '') 
            as billing_country_code,
        nullif(billing_address:first_name::varchar(256), '') 
            as billing_first_name,
        nullif(billing_address:last_name::varchar(256), '') 
            as billing_last_name,
        nullif(billing_address:latitude, '') as billing_latitude,
        nullif(billing_address:longitude, '') as billing_longitude,
        nullif(billing_address:name::varchar(256), '') as billing_name,
        nullif(billing_address:phone::varchar(256), '') as billing_phone,
        nullif(billing_address:province::varchar(256), '') 
            as billing_province,
        nullif(billing_address:province_code::varchar(256), '') 
            as billing_province_code,
        nullif(billing_address:zip::varchar(256), '') as billing_zip,
        
        nullif(shipping_address:address1::varchar(256), '') 
            as shipping_address_address1,
        nullif(shipping_address:address1::varchar(256), '') 
            as shipping_address_address2,
        nullif(shipping_address:city::varchar(256), '') as shipping_city,
        nullif(shipping_address:company::varchar(256), '') 
            as shipping_company,
        nullif(shipping_address:country::varchar(256), '') 
            as shipping_country,
        nullif(shipping_address:country_code::varchar(256), '') 
            as shipping_country_code,
        nullif(shipping_address:first_name::varchar(256), '') 
            as shipping_first_name,
        nullif(shipping_address:last_name::varchar(256), '') 
            as shipping_last_name,
        nullif(shipping_address:longitude, '') as shipping_longitude,
        nullif(shipping_address:latitude, '') as shipping_latitude,
        nullif(shipping_address:name::varchar(256), '') as shipping_name,
        nullif(shipping_address:phone::varchar(256), '') 
            as shipping_phone,
        nullif(shipping_address:province::varchar(256), '') 
            as shipping_province,
        nullif(shipping_address:province_code::varchar(256), '') 
            as shipping_province_code,
        nullif(shipping_address:zip::varchar(256), '') as shipping_zip,
        
        updated_at,
        created_at
    from
        {{ var('checkouts_table') }}

{% endmacro %}