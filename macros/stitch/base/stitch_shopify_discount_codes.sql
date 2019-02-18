{% macro stitch_shopify_discount_codes() %}

    {{ adapter_macro('shopify.stitch_shopify_discount_codes') }}

{% endmacro %}

{% macro default__stitch_shopify_discount_codes() %}

    select

      _sdc_source_key_id as order_id,
      code,
      amount,
      type

    from
      {{ var('discount_codes_table') }}

{% endmacro %}


{% macro snowflake__stitch_shopify_discount_codes() %}

    with order_source_base as (

        select * from {{ var('discount_codes_table')}}

    ),

    discounts_flattened as (

        select

            order_id,
            f.value:code::varchar as code,
            (f.value:amount * -1)::number(38,6) as amount,
            f.value:type::varchar(256) as type

        from order_source_base,
            lateral flatten (input => discount_codes) f
        
    )

    select * from discounts_flattened

{% endmacro %}