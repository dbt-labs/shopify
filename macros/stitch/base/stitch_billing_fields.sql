{% macro stitch_billing_fields() %}
    nullif(billing_address__city::varchar, '') as billing_city,
    nullif(billing_address__province::varchar, '') as billing_province,
    nullif(billing_address__province_code::varchar, '') 
        as billing_province_code,
    nullif(billing_address__country::varchar, '') as billing_country,
    nullif(billing_address__country_code::varchar, '') 
        as billing_country_code,
    nullif(billing_address__zip::varchar, '') as billing_zip_code,
    nullif(billing_address__address1::varchar, '') as billing_address_address1,
    nullif(billing_address__address2::varchar, '') as billing_address_address2,
    nullif(billing_address__company::varchar, '') as billing_company,
    nullif(billing_address__first_name::varchar, '') as billing_first_name,
    nullif(billing_address__last_name::varchar, '') as billing_last_name,
    nullif(billing_address__latitude, '') as billing_latitude,
    nullif(billing_address__longitude, '') as billing_longitude,
    nullif(billing_address__name::varchar, '') as billing_name,
    nullif(billing_address__phone::varchar, '') as billing_phone,
{% endmacro %}



