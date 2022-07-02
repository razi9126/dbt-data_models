{{ config(materialized='ephemeral') }}

with monthly_repeated_behaviour as (
    SELECT
        witness_month,
        behavior,
        COUNT(`behavior`) AS `value_occurrence`
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
    behavior as most_spotted_behavior
from
    (
        select
            witness_month,
            behavior,
            value_occurrence,
            ROW_NUMBER() OVER(
                PARTITION BY witness_month
                ORDER BY
                    value_occurrence desc
            ) as rn
        from
            monthly_repeated_behaviour
        order by
            1 asc,
            3 desc
    )
where
    rn = 1

