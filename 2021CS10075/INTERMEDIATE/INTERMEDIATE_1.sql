with j as (select subject_id , count(  distinct stay_id)   from icustays
group by subject_id),
kk as (
select * from j 
where count > 4
order by count desc , subject_id desc)
select * from  kk
limit 1000 ;
