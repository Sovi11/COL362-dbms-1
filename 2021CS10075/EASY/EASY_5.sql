with j as (select * from icustays
where first_careunit = 'Coronary Care Unit (CCU)'),
k as (
select subject_id , count(*)  from j 
group by subject_id 
),
rr as (select * from k
where count = (select max(count) from k))
select rr.subject_id  ,   patients.anchor_age , rr.count from rr
inner join patients on patients.subject_id = rr.subject_id
order by anchor_age desc ,subject_id desc ;
