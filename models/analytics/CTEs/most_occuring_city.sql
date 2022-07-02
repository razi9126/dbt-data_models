{{ config(materialized='ephemeral') }}

with monthly_repeated_city as (
    SELECT
        witness_month,
        city,
        COUNT(`city`) AS `value_occurrence`
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
    city as most_spotted_city
from
    (
        select
            witness_month,
            city,
            value_occurrence,
            ROW_NUMBER() OVER(
                PARTITION BY witness_month
                ORDER BY
                    value_occurrence desc
            ) as rn
        from
            monthly_repeated_city
        order by
            1 asc,
            3 desc
    )
where
    rn = 1
