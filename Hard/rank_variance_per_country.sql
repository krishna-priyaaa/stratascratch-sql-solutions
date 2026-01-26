--ID 2007

with comments as (
    select a.country, 
    sum(case when b.created_at like '2019-12-%' then b.number_of_comments else 0 end) as dec_comments, 
    sum(case when b.created_at like '2020-01-%' then b.number_of_comments else 0 end) as jan_comments 
    from fb_active_users a left join fb_comments_count b 
    on a.user_id = b.user_id group by 1)

select country from (
    select country, 
    dense_rank() over(order by dec_comments desc) as dec_rank, 
    dense_rank() over(order by jan_comments desc) as jan_rank 
    from comments) a where jan_rank < dec_rank