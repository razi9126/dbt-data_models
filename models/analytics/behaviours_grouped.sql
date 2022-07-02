SELECT
    behavior,
    COUNT(`behavior`) AS `number_of_occurrence`
FROM
    {{ref('sightings')}}
group by
    1
order by
    2 desc