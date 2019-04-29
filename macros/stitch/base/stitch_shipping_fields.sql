{% macro stitch_shopify_shipping_fields() %}

    {{ adapter_macro('shopify.stitch_shopify_shipping_fields') }}

{% endmacro %}

{% macro default__stitch_shopify_shipping_fields() %}

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
    nullif(shipping_address__address1::varchar, '') as shipping_address_address1,
    nullif(shipping_address__address2::varchar, '') as shipping_address_address2,
    nullif(shipping_address__company::varchar, '') as shipping_company,
    nullif(shipping_address__first_name::varchar, '') as shipping_first_name,
    nullif(shipping_address__last_name::varchar, '') as shipping_last_name,
    nullif(shipping_address__name::varchar, '') as shipping_name,
    nullif(shipping_address__phone::varchar, '') as shipping_phone,
    
{% endmacro %}

