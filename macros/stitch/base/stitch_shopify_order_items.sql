{% macro stitch_shopify_order_items() %}

    {{ adapter_macro('shopify.stitch_shopify_order_items') }}

{% endmacro %}

{% macro default__stitch_shopify_order_items() %}

    select

        id as order_item_id,
        _sdc_source_key_id as order_id,
        _sdc_level_0_id as item_id,
        product_id,
        
        sku,
        name,
        title,
        vendor,
        quantity,
        pre_tax_price,
        price,
        taxable,
        gift_card,
        total_discount,
        grams,

        fulfillable_quantity,
        fulfillment_service,
        fulfillment_status,
        
        product_exists,
        requires_shipping,
        
        variant_id,
        variant_inventory_management,
        variant_title

    from
      {{ var('order_items_table') }}

{% endmacro %}


{% macro snowflake__stitch_shopify_order_items() %}

    with orders as (

        select * from {{ var('order_items_table')}}

    ),

    flattened_items as (

        select 

            f.value:id::varchar as order_item_id,
            order_id,
            --item_id
            f.value:product_id::varchar as product_id,
            
            f.value:sku::varchar as sku,
            f.value:name::varchar as name,
            f.value:title::varchar as title,
            f.value:vendor::varchar as vendor,
            f.value:quantity as quantity,
            f.value:pre_tax_price::number(38,6) as pre_tax_price,
            f.value:price::number(38,6) as price,
            f.value:taxable::boolean as taxable,
            f.value:gift_card::boolean as gift_card,
            f.value:total_discount::number(38,6) as total_discount,
            f.value:grams as grams,

            f.value:fulfillment_quantity::varchar as fulfillment_quantity,
            f.value:fulfillment_service::varchar as fulfillment_service,
            f.value:fulfillment_status::varchar as fulfillment_status,
            
            f.value:product_exists::boolean as product_exists,
            f.value:requires_shipping::boolean as requires_shipping,
            
            f.value:variant_id::varchar as variant_id,
            f.value:variant_inventory_management::varchar 
                as variant_inventory_management,
            f.value:variant_title::varchar as variant_title
            
        from orders,
            lateral flatten (input => line_items) f
        
    )

    select * from flattened_items

{% endmacro %}