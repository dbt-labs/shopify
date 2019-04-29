{% macro stitch_nested_field(field, subfields, final_field_name) %}

    {{ adapter_macro('shopify.stitch_nested_field', field, subfields) }}

{% endmacro %}

{% macro default__stitch_nested_field(field, subfields, final_field_name) %}

{{field}}__{{ subfields|join('__') }} as {{final_field_name}}

{% endmacro %}


{% macro snowflake__stitch_nested_field(field, subfields, final_field_name) %}

{{field ~ "['" ~ subfields|join("']['") ~ "']" }} as {{final_field_name}}

{%- endmacro %}


