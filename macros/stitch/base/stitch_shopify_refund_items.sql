{% macro stitch_shopify_refund_items() %}

    {{ adapter_macro('shopify.stitch_shopify_refund_items') }}

{% endmacro %}

{% macro default__stitch_shopify_refund_items() %}

    select

        id as refund_line_item_id,
        _sdc_source_key_id as refund_id, 
        line_item_id,
        subtotal * -1 as refund_amount,
        total_tax * -1 as refund_tax_amount

    from
        {{ var('refund_items_table') }}

{% endmacro %}


{% macro snowflake__stitch_shopify_refund_items() %}

    with shopify_order_source as (

        select * from {{ var('refund_items_table')}}

    ),

    refunds_flattened as (

        select

            f.value:id as refund_id,
            f1.value:id as refund_line_item_id,
            f1.value:line_item_id as line_item_id,
            f1.value:subtotal::number(38,6) * -1 as refund_amount,
            f1.value:total_tax::number(38,6) * -1 as refund_tax_amount

        from shopify_order_source,
            lateral flatten (input => refunds, outer => true) f,
            lateral flatten (input => f.value:refund_line_items, outer => true) f1

    )

    select * from refunds_flattened

{% endmacro %}