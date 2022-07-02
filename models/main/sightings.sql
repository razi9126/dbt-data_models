{% set all_sources = ['Africa','America','Asia','Atlantic','Australia','Europe','Indian','Pacific']%}

{% for region in all_sources %}
    SELECT 
        date_witness,
        date_agent, 
        agent, 
        city,
        city_agent, 
        has_weapon,
        has_hat,
        has_jacket, 
        behavior,
        date_trunc(date_witness,month) as witness_month  
    FROM {{ref(region)}} 

    {% if not loop.last %}  
    UNION ALL  
    {% endif %}
{% endfor -%}