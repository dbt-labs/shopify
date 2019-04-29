{% macro stitch_quoted_field(quoted_field, field_name) %}
  {{ adapter_macro('shopify.stitch_quoted_field', quoted_field, field_name) }}
{% endmacro %}

{% macro default__stitch_quoted_field(quoted_field, field_name) %}
    "{{quoted_field}}" as {{field_name}}
{% endmacro %}

{% macro snowflake__stitch_quoted_field(quoted_field, field_name) %}
    {{quoted_field}} as {{field_name}}
{% endmacro %}