--ID 10172

select month, description, total_paid from (
    select description, 
    month(invoicedate) as month, 
    sum(unitprice*quantity) as total_paid, 
    rank() over(partition by month(invoicedate) order by sum(unitprice*quantity) desc) as rnk 
    from online_retail group by 1,2) a where rnk = 1