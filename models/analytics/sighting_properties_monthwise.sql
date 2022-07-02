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
),
most_repeated_behavior as (
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
),
monthly_repeated_city as (
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
),
most_repeated_city as (
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
),
monthly_repeated_city_agent as (
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
),
most_repeated_city_agent as (
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
)
select
    sightings.witness_month,
    city.most_spotted_city,
    behavior.most_spotted_behavior,
    agency.most_spotted_agency,
    count(*) as total_occurences,
    SUM(
        CASE
            WHEN sightings.has_hat = TRUE THEN 1
            ELSE 0
        END
    ) as occurrences_with_hat,
    SUM(
        CASE
            WHEN sightings.has_weapon = TRUE THEN 1
            ELSE 0
        END
    ) as occurrences_with_weapon,
    SUM(
        CASE
            WHEN sightings.has_jacket = TRUE THEN 1
            ELSE 0
        END
    ) as occurrences_with_jacket
from
    {{ref('sightings')}} sightings
    left join most_repeated_city city on city.witness_month = sightings.witness_month
    left join most_repeated_city_agent agency on agency.witness_month = sightings.witness_month
    left join most_repeated_behavior behavior on behavior.witness_month = sightings.witness_month
group by
    1,
    2,
    3,
    4