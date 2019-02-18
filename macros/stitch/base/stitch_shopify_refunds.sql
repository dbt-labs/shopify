{% macro stitch_shopify_refunds() %}

    {{ adapter_macro('shopify.stitch_shopify_refunds') }}

{% endmacro %}

{% macro default__stitch_shopify_refunds() %}

{% set window_clause = "over (partition by refund_id order by processed_at
    rows between unbounded preceding and unbounded following)" %}

with refunds as (

    select * from {{ var('refunds_table')}}
    
),

adjustments as (
    
    select * from {{ var('refund_adjustments_table')}}
    
),

item_refunds as (
    
    select 
        refund_id,
        sum(refund_amount) as refund_amount,
        sum(refund_tax_amount) as refund_tax_amount
    from {{ ref('stg_shopify_refund_items') }}
    group by 1

),

joined as (

    select 
        adjustments.*,
        refunds.processed_at::timestamp as processed_at
    from adjustments
    left join refunds
        on refunds._sdc_source_key_id = adjustments._sdc_source_key_id
    
),

adjustments_flattened as (

    select distinct
        
        id as refund_id,
        _sdc_source_key_id as order_id,
        sum(case when reason ilike '%ship%' then amount else 0 end) 
            {{window_clause}} as refund_shipping_amount,
        sum(case when reason ilike '%refund discrepancy%' then amount else 0 end) 
            {{window_clause}} as adjustment_refund_amount,
        sum(tax_amount) {{window_clause}} as refund_tax_amount,
        processed_at as refund_processed_at

    from order_source
        
),

final as (
    
    select 
        adjustments_flattened.refund_id, 
        adjustments_flattened.order_id,
        coalesce(adjustments_flattened.adjustment_refund_amount,0) +
            coalesce(item_refunds.refund_amount, 0) as refund_amount,
        coalesce(adjustments_flattened.refund_tax_amount,0) +
            coalesce(item_refunds.refund_tax_amount, 0) as refund_tax_amount,
        coalesce(adjustments_flattened.refund_shipping_amount, 0) 
            as refund_shipping_amount,
        adjustments_flattened.refund_processed_at
    from adjustments_flattened
    left join item_refunds using (refund_id)
    
)

select * from final

{% endmacro %}


{% macro snowflake__stitch_shopify_refunds() %}

{% set window_clause = "over
    (partition by refund_id order by f.value:processed_at::timestampntz
    rows between unbounded preceding and unbounded following)" %}

with order_source as (

    select * from {{ var('refunds_table')}}
    
),

item_refunds as (
    
    select 
        refund_id,
        sum(refund_amount) as refund_amount,
        sum(refund_tax_amount) as refund_tax_amount
    from {{ ref('stg_shopify_refund_items') }}
    group by 1

),

adjustments_flattened as (

    select distinct
        
        f.value:id as refund_id,
        order_id,
        sum(case when f1.value:reason ilike '%ship%' then f1.value:amount 
            else 0 end) 
            {{window_clause}} as refund_shipping_amount,
        sum(case when f1.value:reason ilike '%refund discrepancy%' 
            then f1.value:amount 
            else 0 end) 
            {{window_clause}} as adjustment_refund_amount,
        sum(f1.value:tax_amount) {{window_clause}} as refund_tax_amount,
        f.value:processed_at::timestampntz as refund_processed_at

    from order_source,
        lateral flatten (input => refunds, outer => true) f,
        lateral flatten (input => f.value:order_adjustments, outer => true) f1
    
        
),

final as (
    
    select 
        adjustments_flattened.refund_id, 
        adjustments_flattened.order_id,
        coalesce(adjustments_flattened.adjustment_refund_amount,0) +
            coalesce(item_refunds.refund_amount, 0) as refund_amount,
        coalesce(adjustments_flattened.refund_tax_amount,0) +
            coalesce(item_refunds.refund_tax_amount, 0) as refund_tax_amount,
        coalesce(adjustments_flattened.refund_shipping_amount, 0) 
            as refund_shipping_amount,
        adjustments_flattened.refund_processed_at
    from adjustments_flattened
    left join item_refunds using (refund_id)
    
)

select * from final


{% endmacro %}