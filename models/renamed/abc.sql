select
  {{ dbt_utils.star(ref('ASIA_csv')) }}
from {{ ref('ASIA_csv') }}