{% macro stitch_shopify_checkouts() %}

    {{ adapter_macro('shopify.stitch_shopify_checkouts') }}

{% endmacro %}

{% macro default__stitch_shopify_checkouts() %}
    
    select
    
        --ids
        id as checkout_id,
        {{shopify.stitch_nested_field(
            field = 'customer', 
            subfields = ['id'], 
            casting = 'bigint',
            final_field_name = 'customer_id')}},
        nullif(lower(email), '') as email,
        nullif(cart_token, '') as cart_token,
        nullif(token, '') as token,
        
        --fields 
        abandoned_checkout_url,
        name,
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
        
        {{ shopify.stitch_shopify_billing_fields() }}
        
        {{ shopify.stitch_shopify_shipping_fields() }}
                
        --dates        
        completed_at,
        created_at,
        updated_at
        
    from
        {{ var('checkouts_table') }}
    

{% endmacro %}