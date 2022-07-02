
{% set all_sources = ['Africa','America','Asia','Atlantic','Australia','Europe','Indian','Pacific']%}

{% for region in all_sources %}
    SELECT 
        distinct date_witness, 
        witness 
    FROM {{ref(region)}} 
    group by 1,2
    {% if not loop.last %}
     UNION ALL 
    {% endif %}
{% endfor -%}