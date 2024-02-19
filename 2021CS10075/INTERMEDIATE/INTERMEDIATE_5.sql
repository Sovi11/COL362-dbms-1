with k as (select labevents.itemid, labevents.subject_id , labevents.hadm_id, icustays.intime , icustays.outtime , icustays.los from labevents 
inner join icustays on (labevents.subject_id = icustays.subject_id and labevents.hadm_id = icustays.hadm_id )),
r as (select *, outtime - intime as duration  from k 
where ((los is not null) and itemid = '50878')),
dd as (select subject_id , hadm_id , avg(duration) as avg_stay_duration from r 
group by (subject_id,hadm_id)),
kk as(
select subject_id , avg_stay_duration from dd 
order by avg_stay_duration desc , subject_id desc)
select * from kk
limit 1000 ;
