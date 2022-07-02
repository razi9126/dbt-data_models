with
most_repeated_behavior as (
    select
        *
    from
        {{ref('most_occuring_behaviour')}}
),

most_repeated_city as (
    select
        *
    from
        {{ref('most_occuring_city')}}
),

most_repeated_city_agent as (
    select
        *
    from
        {{ref('most_occuring_city_agent')}}
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
order by 
    1