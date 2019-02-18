{% macro stitch_shopify_transactions() %}

    {{ adapter_macro('shopify.stitch_shopify_transactions') }}

{% endmacro %}

{% macro default__stitch_shopify_transactions() %}

    select

        id as transaction_id,
        parent_id,
        order_id,

        status,
        error_code,
        message,

        kind,
        amount,
        "authorization",
        currency,
        gateway,

        source_name,

        created_at

    from
        {{ var('transactions_table') }}

    where
        -- filter test transactions
        test = false


{% endmacro %}


{% macro snowflake__stitch_shopify_transactions() %}

    select

        id as transaction_id,
        parent_id,
        order_id,

        status,
        error_code,
        message,

        kind,
        amount,
        authorization,
        currency,
        gateway,

        source_name,

        created_at

    from
        {{ var('transactions_table') }}

    where
        -- filter test transactions
        test = false

{% endmacro %}