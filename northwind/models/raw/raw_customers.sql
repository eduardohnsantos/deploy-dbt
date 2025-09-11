select *
from {{ source('crm', 'customers') }}
