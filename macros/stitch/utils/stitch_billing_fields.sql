{% macro stitch_shopify_billing_fields() %}

    {{ adapter_macro('shopify.stitch_shopify_billing_fields') }}

{% endmacro %}

{% macro default__stitch_shopify_billing_fields() %}

    {{shopify.stitch_nested_field(
        field = 'billing_address', 
        subfields = ['city'], 
        casting = 'varchar(256)',
        final_field_name = 'billing_city')}},
        
    {{shopify.stitch_nested_field(
        field = 'billing_address', 
        subfields = ['province'], 
        casting = 'varchar(256)',
        final_field_name = 'billing_province')}},
        
    {{shopify.stitch_nested_field(
        field = 'billing_address', 
        subfields = ['province_code'], 
        casting = 'varchar(256)',
        final_field_name = 'billing_province_code')}},
        
    {{shopify.stitch_nested_field(
        field = 'billing_address', 
        subfields = ['country'], 
        casting = 'varchar(256)',
        final_field_name = 'billing_country')}},
        
    {{shopify.stitch_nested_field(
        field = 'billing_address', 
        subfields = ['country_code'], 
        casting = 'varchar(256)',
        final_field_name = 'billing_country_code')}},
        
    {{shopify.stitch_nested_field(
        field = 'billing_address', 
        subfields = ['zip'], 
        casting = 'varchar(256)',
        final_field_name = 'billing_zip_code')}},
        
    {{shopify.stitch_nested_field(
        field = 'billing_address', 
        subfields = ['address1'], 
        casting = 'varchar(256)',
        final_field_name = 'billing_address_address1')}},
        
    {{shopify.stitch_nested_field(
        field = 'billing_address', 
        subfields = ['address2'], 
        casting = 'varchar(256)',
        final_field_name = 'billing_address_address2')}},
        
    {{shopify.stitch_nested_field(
        field = 'billing_address', 
        subfields = ['company'], 
        casting = 'varchar(256)',
        final_field_name = 'billing_company')}},
        
    {{shopify.stitch_nested_field(
        field = 'billing_address', 
        subfields = ['first_name'], 
        casting = 'varchar(256)',
        final_field_name = 'billing_first_name')}},
        
    {{shopify.stitch_nested_field(
        field = 'billing_address', 
        subfields = ['last_name'], 
        casting = 'varchar(256)',
        final_field_name = 'billing_last_name')}},
        
    {{shopify.stitch_nested_field(
        field = 'billing_address', 
        subfields = ['latitude'], 
        casting = 'bigint',
        final_field_name = 'billing_latitude')}},
        
    {{shopify.stitch_nested_field(
        field = 'billing_address', 
        subfields = ['longitude'], 
        casting = 'bigint',
        final_field_name = 'billing_longitude')}},
        
    {{shopify.stitch_nested_field(
        field = 'billing_address', 
        subfields = ['name'], 
        casting = 'varchar(256)',
        final_field_name = 'billing_name')}},
        
    {{shopify.stitch_nested_field(
        field = 'billing_address', 
        subfields = ['phone'], 
        casting = 'varchar(256)',
        final_field_name = 'billing_phone')}},

    
{% endmacro %}


