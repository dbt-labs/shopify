{% macro stitch_shopify_checkouts() %}

    {{ adapter_macro('shopify.stitch_shopify_checkouts') }}

{% endmacro %}

{% macro default__stitch_shopify_checkouts() %}
    
    select
        id as checkout_id,
        customer__id as customer_id,
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
        
        nullif(lower(billing_address__address1), '') as billing_address_address1,
        nullif(lower(billing_address__address2), '') as billing_address_address2,
        nullif(lower(billing_address__city), '') as billing_city,
        nullif(lower(billing_address__company), '') as billing_company,
        nullif(lower(billing_address__country), '') as billing_country,
        nullif(lower(billing_address__country_code), '') as billing_country_code,
        nullif(lower(billing_address__first_name), '') as billing_first_name,
        nullif(lower(billing_address__last_name), '') as billing_last_name,
        nullif(billing_address__latitude, '') as billing_latitude,
        nullif(billing_address__longitude, '') as billing_longitude,
        nullif(lower(billing_address__name), '') as billing_name,
        nullif(lower(billing_address__phone), '') as billing_phone,
        nullif(lower(billing_address__province), '') as billing_province,
        nullif(lower(billing_address__province_code), '') 
            as billing_province_code,
        nullif(lower(billing_address__zip), '') as billing_zip,
            
        nullif(lower(shipping_address__address1), '') 
            as shipping_address_address1,
        nullif(lower(shipping_address__address2), '') 
            as shipping_address_address2,
        nullif(lower(shipping_address__city), '') as shipping_city,
        nullif(lower(shipping_address__company), '') as shipping_company,
        nullif(lower(shipping_address__country), '') as shipping_country,
        nullif(lower(shipping_address__country_code), '') 
            as shipping_country_code,
        nullif(lower(shipping_address__first_name), '') as shipping_first_name,
        nullif(lower(shipping_address__last_name), '') as shipping_last_name,
        nullif(shipping_address__longitude, '') as shipping_longitude,
        nullif(shipping_address__latitude, '') as shipping_latitude,
        nullif(lower(shipping_address__name), '') as shipping_name,
        nullif(lower(shipping_address__phone), '') as shipping_phone,
        nullif(lower(shipping_address__province), '') as shipping_province,
        nullif(lower(shipping_address__province_code), '') 
            as shipping_province_code,
        nullif(lower(shipping_address__zip), '') as shipping_zip,
        
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
        
        nullif(lower(billing_address:address1::varchar(256)), '') 
            as billing_address_address1,
        nullif(lower(billing_address:address1::varchar(256)), '') 
            as billing_address_address2,
        nullif(lower(billing_address:city::varchar(256)), '') as billing_city,
        nullif(lower(billing_address:company::varchar(256)), '') 
            as billing_company,
        nullif(lower(billing_address:country::varchar(256)), '') 
            as billing_country,
        nullif(lower(billing_address:country_code::varchar(256)), '') 
            as billing_country_code,
        nullif(lower(billing_address:first_name::varchar(256)), '') 
            as billing_first_name,
        nullif(lower(billing_address:last_name::varchar(256)), '') 
            as billing_last_name,
        nullif(billing_address:latitude, '') as billing_latitude,
        nullif(billing_address:longitude, '') as billing_longitude,
        nullif(lower(billing_address:name::varchar(256)), '') as billing_name,
        nullif(lower(billing_address:phone::varchar(256)), '') as billing_phone,
        nullif(lower(billing_address:province::varchar(256)), '') 
            as billing_province,
        nullif(lower(billing_address:province_code::varchar(256)), '') 
            as billing_province_code,
        nullif(lower(billing_address:zip::varchar(256)), '') as billing_zip,
        
        nullif(lower(shipping_address:address1::varchar(256)), '') 
            as shipping_address_address1,
        nullif(lower(shipping_address:address1::varchar(256)), '') 
            as shipping_address_address2,
        nullif(lower(shipping_address:city::varchar(256)), '') as shipping_city,
        nullif(lower(shipping_address:company::varchar(256)), '') 
            as shipping_company,
        nullif(lower(shipping_address:country::varchar(256)), '') 
            as shipping_country,
        nullif(lower(shipping_address:country_code::varchar(256)), '') 
            as shipping_country_code,
        nullif(lower(shipping_address:first_name::varchar(256)), '') 
            as shipping_first_name,
        nullif(lower(shipping_address:last_name::varchar(256)), '') 
            as shipping_last_name,
        nullif(shipping_address:longitude, '') as shipping_longitude,
        nullif(shipping_address:latitude, '') as shipping_latitude,
        nullif(lower(shipping_address:name::varchar(256)), '') as shipping_name,
        nullif(lower(shipping_address:phone::varchar(256)), '') 
            as shipping_phone,
        nullif(lower(shipping_address:province::varchar(256)), '') 
            as shipping_province,
        nullif(lower(shipping_address:province_code::varchar(256)), '') 
            as shipping_province_code,
        nullif(lower(shipping_address:zip::varchar(256)), '') as shipping_zip,
        
        updated_at,
        created_at
    from
        {{ var('checkouts_table') }}

{% endmacro %}