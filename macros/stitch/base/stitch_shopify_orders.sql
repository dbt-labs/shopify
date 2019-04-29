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
        {{shopify.stitch_nested_field(
            field = 'customer', 
            subfields = ['id'],
            casting = 'bigint',
            final_field_name = 'customer_id')}},
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
        
        {{shopify.stitch_quoted_field('number', 'internal_number')}},
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
        
        {{shopify.stitch_nested_field(
            field = 'total_shipping_price_set', 
            subfields = ['presentment_money', 'amount'],
            casting = 'decimal(38,6)',
            final_field_name = 'total_shipping_cost_base')}},
        
        {{shopify.stitch_nested_field(
            field = 'total_shipping_price_set', 
            subfields = ['presentment_money', 'currency_code'],
            casting = 'varchar(128)',
            final_field_name = 'shipping_currency_code')}},
            
        tags,
        taxes_included, --true/false
        order_status_url,
        
        --addresses
        location_id,
        
        {{ shopify.stitch_shopify_shipping_fields() }}
        
        {{ shopify.stitch_shopify_billing_fields() }}
        
        -- browser attributes
        referring_site,
        browser_ip,
        landing_site,
        source_name,
        
        {% if target.type == 'snowflake' %}
        
            -- these nested fields are needed for snowflake to denest in 
            -- other models
            
            note,
            total_shipping_price_set,
            refunds,
            discount_codes,
            line_items,
            shipping_lines,
            
        {% endif %}
        
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