{% macro stitch_shopify_customers() %}

    {{ adapter_macro('shopify.stitch_shopify_customers') }}

{% endmacro %}

{% macro default__stitch_shopify_customers() %}

    select
        
        --ids
        id as customer_id,
        
        --dimensions
        nullif(lower(email), '') as email,
        verified_email,
        nullif(first_name, '') as first_name,
        nullif(last_name, '') as last_name,
        accepts_marketing,
        state,
        tags,
        tax_exempt,
        
        {{shopify.stitch_nested_field(
            field = 'default_address', 
            subfields = ['id'],
            casting = 'bigint',
            final_field_name = 'default_address_id')}},
        
        --dates
        created_at,
        updated_at
        
    from
        {{ var('customers_table') }}

{% endmacro %}

{% macro snowflake__stitch_shopify_customers() %}

    select
        
        --ids
        id as customer_id,
        
        --dimensions
        nullif(lower(email), '') as email,
        verified_email,
        nullif(first_name, '') as first_name,
        nullif(last_name, '') as last_name,
        accepts_marketing,
        state,
        tags,
        tax_exempt,
        
        default_address:id::number(38,6) as default_address_id,
        
        --dates
        created_at,
        updated_at
        
    from
        {{ var('customers_table') }}

{% endmacro %}