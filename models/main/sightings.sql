{% set all_sources = ['Africa','America','Asia','Atlantic','Australia','Europe','Indian','Pacific']%}

{% for region in all_sources %}
    SELECT date_witness,date_agent, witness,agent, city, has_weapon,has_hat,has_jacket,behaviour  FROM {{ref(region)}} 
    {%- if not loop.last -%} UNION ALL {% endif %}
{% endfor -%}