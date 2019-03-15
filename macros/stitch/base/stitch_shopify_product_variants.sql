{% macro stitch_shopify_product_variants() %}

    {{ adapter_macro('shopify.stitch_shopify_product_variants') }}

{% endmacro %}

{% macro default__stitch_shopify_product_variants() %}

    select

        id as variant_id,
        _sdc_source_key_id as product_id,
        inventory_item_id,
        
        barcode,
        fulfillment_service,
        grams,
        inventory_policy,
        inventory_quantity,
        inventory_management,
        position,
        price,
        
        requires_shipping,
        sku,
        taxable,
        title,
        weight,
        weight_unit,
        
        created_at,
        updated_at

    from
        {{ var('products_variants_table') }}

{% endmacro %}


{% macro snowflake__stitch_shopify_product_variants() %}
    
    select

        f.value:id::number(38,6) as variant_id,
        product_id,
        f.value:inventory_item_id::number(38,6) as inventory_item_id,
     
        f.value:barcode::varchar(256) as barcode,
        f.value:fulfillment_service::varchar(256) as fulfillment_service,
        f.value:grams::number(38,6) as grams,
        
        f.value:inventory_policy::varchar(256) as inventory_policy,
        f.value:inventory_quantity::number(38,6) as inventory_quantity,
        f.value:inventory_management::varchar(256) as inventory_management,
        f.value:position::number(38,6) as position,
        f.value:price::number(38,6) as price,
       
        f.value:requires_shipping::boolean as requires_shipping,
        f.value:sku::varchar(256) as sku,
        f.value:taxable::boolean as taxable,
        f.value:title::varchar(256) as title,
        f.value:weight::number(38,6) as weight,
        f.value:weight_unit::varchar(256) as weight_unit,
        
        created_at,
        updated_at

    from {{ ref('stg_shopify_products') }},
    lateral flatten (input => variants) f

{% endmacro %}