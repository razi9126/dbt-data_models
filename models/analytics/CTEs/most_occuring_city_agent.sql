{{ config(materialized='ephemeral') }}

with monthly_repeated_city_agent as (
    SELECT
        witness_month,
        city_agent,
        COUNT(`city_agent`) AS `value_occurrence`
    FROM
        {{ref('sightings')}}
    group by
        1,
        2
    order by
        1 asc,
        3 desc
)
select
    witness_month,
    city_agent as most_spotted_agency
from
    (
        select
            witness_month,
            city_agent,
            value_occurrence,
            ROW_NUMBER() OVER(
                PARTITION BY witness_month
                ORDER BY
                    value_occurrence desc
            ) as rn
        from
            monthly_repeated_city_agent
        order by
            1 asc,
            3 desc
    )
where
    rn = 1
