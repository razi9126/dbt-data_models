select 
date_witness,
witness,
agent,
date_agent,
region_hq as city_agent,
country,
city,
latitude,
longitude,
has_weapon,
has_hat,
has_jacket,
behaviour
from {{ref('AMERICA_csv')}} 