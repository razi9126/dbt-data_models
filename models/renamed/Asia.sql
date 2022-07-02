select 
sighting as date_witness,
citizen as witness,
officer as agent,
b as date_agent,
city_interpol as city_agent,
nation as country,
city as city,
e as latitude,
f as longitude,
has_weapon,
has_hat,
has_jacket,
behaviour
from {{ref('ASIA_csv')}} 