{% macro stitch_nested_field(field, subfields, casting, final_field_name) %}

    {{ adapter_macro('shopify.stitch_nested_field', field, subfields, casting, final_field_name) }}

{% endmacro %}

{% macro default__stitch_nested_field(field, subfields, casting, final_field_name) %}

{{field}}__{{ subfields|join('__') }}::{{casting}} as {{final_field_name}}

{% endmacro %}


{% macro snowflake__stitch_nested_field(field, subfields, casting, final_field_name) %}

{{field ~ "['" ~ subfields|join("']['") ~ "']" }}::{{casting}} as {{final_field_name}}

{%- endmacro %}


