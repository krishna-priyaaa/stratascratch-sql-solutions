--ID 10547

with rating as(
select actor_name, film_rating, 
rank() over(partition by actor_name order by release_date desc) as rnk, 
release_date from actor_rating_shift),
latest as(
select actor_name, film_rating as latest_rating from rating where rnk=1),
lifetime as(
select actor_name, avg(film_rating) as lifetime_rating from rating where rnk>1 group by 1)
--lifetime rating considers all films except the latest one

select a.actor_name, a.latest_rating,i
ifnull(b.lifetime_rating, a.latest_rating) as lifetime_rating, 
round(ifnull(b.lifetime_rating, a.latest_rating) - a.latest_rating,2) as rating_difference 
from latest a left join lifetime b on a.actor_name = b.actor_name order by a.actor_name
