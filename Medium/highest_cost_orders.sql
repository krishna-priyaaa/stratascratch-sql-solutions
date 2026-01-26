--ID 9915

select b.first_name, a.total_cost, a.order_date from (
    select cust_id, order_date, sum(total_order_cost) as total_cost, 
    rank() over (partition by  order_date order by sum(total_order_cost) desc) as rnk 
    from orders group by 1,2) a left join customers b 
    on a.cust_id = b.id 
    where a.rnk=1 
    and a.order_date >= '2019-02-01' 
    and a.order_date <= '2019-05-01'