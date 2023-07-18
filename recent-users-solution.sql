---creating a CTE, instead of a self join, I used window function(lead), which ----actuallyreduces the bottle neck in the database and gives fast result.

with rr as (select user_id, datediff(day,created_at,
lead(created_at) over (partition by user_id order by created_at )) recent_user
from amazon_transactions
group by user_id,created_at
)

---- calling the cte in the main query
select user_id
from rr 
where  recent_user <= 7
group by user_id

