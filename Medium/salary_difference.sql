--ID 10308

with salaries as(
    select a.department, 
    (case when a.department = 'marketing' then max(b.salary) else 0 end) as max_mkt_s, 
    (case when a.department = 'engineering' then max(b.salary) else 0 end) as max_engg_s  
    from db_dept a inner join db_employee b on a.id = b.department_id group by 1)

select abs(sum(max_mkt_s)-sum(max_engg_s)) as salary_difference from salaries;