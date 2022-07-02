{% macro replace_column_name(column_name) %}
    {% if 'behavior' in column_name %}
        {% set result = column_name %}
    {% elif 'hat' in column_name %}
        {% set result = 'has_hato' %}
    {% else %}
        {% set result = column_name %}
    {% endif -%}
    {{ return(result) }}
{% endmacro %}