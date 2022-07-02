{%- set behaviors = dbt_utils.get_column_values(table=ref('sightings'), column='behavior', max_records=50) -%}

select
    witness_month,
    {%- for behavior in behaviors %}
    sum(case when behavior = '{{behavior}}' then 1 end) as {{behavior}}_occurence,
    {% endfor %}
    count(*) as total_occurences
from {{ ref('sightings') }}
group by 
    1