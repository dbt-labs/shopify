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
        
        {{shopify.stitch_nested_field(
            field = 'image', 
            subfields = ['src'],
            casting = 'varchar(256)',
            final_field_name = 'image_url')}},
            
        {% if target.type == 'snowflake' %}        
            variants,
        {% endif %}

        --dates
        published_at,
        created_at,
        updated_at

    from
      {{ var('products_table') }}

{% endmacro %}