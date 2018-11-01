-- start query 1 in stream 0 using template query1.tpl
select sr_customer_sk as ctr_customer_sk
,sr_store_sk as ctr_store_sk
,sum(SR_FEE) as ctr_total_return
into temp customer_total_return
from store_returns
,date_dim
where sr_returned_date_sk = d_date_sk
and d_year =2000
group by sr_customer_sk
,sr_store_sk;

SELECT ctr_store_sk, AVG(ctr_total_return) as t_avg
into temp ctr_total_return_avg
from customer_total_return
group by ctr_store_sk;

SELECT
    c_customer_id
FROM
    customer_total_return ctr1 ,
    ctr_total_return_avg ctr2,
    store ,
    customer
WHERE
    ctr1.ctr_total_return > ctr2.t_avg * 1.2
    and  ctr1.ctr_store_sk = ctr2.ctr_store_sk
AND s_store_sk = ctr1.ctr_store_sk
AND s_state = 'TN'
AND ctr1.ctr_customer_sk = c_customer_sk
ORDER BY
    c_customer_id limit 100;

-- end query 1 in stream 0 using template query1.tpl
