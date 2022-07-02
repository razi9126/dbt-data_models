{% macro standardize_column(table_name) %}
    {% set all_columns = adapter.get_columns_in_relation(
        ref(table_name)
    ) %}

    select
    {% for col in all_columns %}

    {%- if col.name in ['date_witness','sighting','witnessed','sight_on'] -%}
        {{col.name}} as date_witness
    {%- elif col.name in ['witness','citizen','observer','sighter'] -%}
        {{col.name}} as witness
    {%- elif col.name in ['agent','officer','field_chap','filer'] -%}
        {{col.name}} as agent
    {%- elif col.name in ['date_agent','b','file_on','reported','date_filed'] -%}
        {{col.name}} as date_agent
    {%- elif col.name in ['region_hq','city_interpol','interpol_spot','report_office'] -%}
        {{col.name}} as city_agent
    {%- elif col.name in ['country','nation'] -%}
        {{col.name}} as country
    {%- elif col.name in ['city','place','town'] -%}
        {{col.name}} as city
    {%- elif col.name in ['lat_','lat','latitude','e'] -%}
        {{col.name}} as latitude
    {%- elif col.name in ['long_','long','longitude','f'] -%}
        {{col.name}} as longitude
    {%- elif col.name in ['has_weapon','armed'] -%}
        {{col.name}} as has_weapon
    {%- elif col.name in ['chapeau','has_hat'] -%}
        {{col.name}} as has_hat
    {%- elif col.name in ['has_jacket','coat'] -%}
        {{col.name}} as has_jacket
    {%- elif col.name in ['behaviour','state_of_mind','observed_action'] -%}
        {{col.name}} as behaviour
    {%- else -%}
        {{col.name}}
    {%- endif -%}
    {%- if not loop.last -%} , {% endif %}
    {% endfor -%}
    from {{ref(table_name)}}

{% endmacro %}