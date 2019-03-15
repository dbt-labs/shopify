{% macro stitch_shopify_products() %}

    {{ adapter_macro('shopify.stitch_shopify_products') }}

{% endmacro %}

{% macro default__stitch_shopify_products() %}

    select

        id as product_id,
        nullif(lower(product_type), '') as product_type,
        nullif(lower(title), '') as title,
        handle,
        published_scope,
        tags,
        vendor,

        body_html,
        image__src as image_url,

        --dates
        published_at,
        created_at,
        updated_at

    from
      {{ var('products_table') }}

{% endmacro %}


{% macro snowflake__stitch_shopify_products() %}

    select

        id as product_id,
        nullif(lower(product_type), '') as product_type,
        nullif(lower(title), '') as title,
        handle,
        published_scope,
        tags,
        vendor,
        
        variants,
        body_html,
        image:src::string as image_url,

        --dates
        published_at,
        created_at,
        updated_at

    from
      {{ var('products_table') }}

{% endmacro %}