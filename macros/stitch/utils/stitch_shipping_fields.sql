{% macro stitch_shopify_shipping_fields() %}

    {{ adapter_macro('shopify.stitch_shopify_shipping_fields') }}

{% endmacro %}

{% macro default__stitch_shopify_shipping_fields() %}

    {{shopify.stitch_nested_field(
        field = 'shipping_address', 
        subfields = ['city'], 
        casting = 'varchar(256)',
        final_field_name = 'shipping_city')}},
        
    {{shopify.stitch_nested_field(
        field = 'shipping_address', 
        subfields = ['province'], 
        casting = 'varchar(256)',
        final_field_name = 'shipping_province')}},
        
    {{shopify.stitch_nested_field(
        field = 'shipping_address', 
        subfields = ['province_code'], 
        casting = 'varchar(256)',
        final_field_name = 'shipping_province_code')}},
        
    {{shopify.stitch_nested_field(
        field = 'shipping_address', 
        subfields = ['country'], 
        casting = 'varchar(256)',
        final_field_name = 'shipping_country')}},
        
    {{shopify.stitch_nested_field(
        field = 'shipping_address', 
        subfields = ['country_code'], 
        casting = 'varchar(256)',
        final_field_name = 'shipping_country_code')}},
        
    {{shopify.stitch_nested_field(
        field = 'shipping_address', 
        subfields = ['zip'], 
        casting = 'varchar(256)',
        final_field_name = 'shipping_zip_code')}},
        
    {{shopify.stitch_nested_field(
        field = 'shipping_address', 
        subfields = ['address1'], 
        casting = 'varchar(256)',
        final_field_name = 'shipping_address_address1')}},
        
    {{shopify.stitch_nested_field(
        field = 'shipping_address', 
        subfields = ['address2'], 
        casting = 'varchar(256)',
        final_field_name = 'shipping_address_address2')}},
        
    {{shopify.stitch_nested_field(
        field = 'shipping_address', 
        subfields = ['company'], 
        casting = 'varchar(256)',
        final_field_name = 'shipping_company')}},
        
    {{shopify.stitch_nested_field(
        field = 'shipping_address', 
        subfields = ['first_name'], 
        casting = 'varchar(256)',
        final_field_name = 'shipping_first_name')}},
        
    {{shopify.stitch_nested_field(
        field = 'shipping_address', 
        subfields = ['last_name'], 
        casting = 'varchar(256)',
        final_field_name = 'shipping_last_name')}},
        
    {{shopify.stitch_nested_field(
        field = 'shipping_address', 
        subfields = ['latitude'], 
        casting = 'bigint',
        final_field_name = 'shipping_latitude')}},
        
    {{shopify.stitch_nested_field(
        field = 'shipping_address', 
        subfields = ['longitude'], 
        casting = 'bigint',
        final_field_name = 'shipping_longitude')}},
        
    {{shopify.stitch_nested_field(
        field = 'shipping_address', 
        subfields = ['name'], 
        casting = 'varchar(256)',
        final_field_name = 'shipping_name')}},
        
    {{shopify.stitch_nested_field(
        field = 'shipping_address', 
        subfields = ['phone'], 
        casting = 'varchar(256)',
        final_field_name = 'shipping_phone')}},
    
{% endmacro %}

