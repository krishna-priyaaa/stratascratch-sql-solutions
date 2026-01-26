--ID 2054

with tbl as(
select user_id, record_date, 
lag(record_date,1) over(order by user_id, record_date asc) as nxt_1, 
lag(record_date,2) over(order by user_id, record_date asc) as nxt_2 from sf_events)

select user_id from tbl 
where datediff(record_date, nxt_1) = 1 and datediff(nxt_1, nxt_2) = 1