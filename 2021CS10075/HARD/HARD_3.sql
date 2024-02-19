with ii as (select subject_id , hadm_id , intime , outtime from icustays),
j as(
select procedures_icd.icd_code , procedures_icd.icd_version , ii.* from procedures_icd
inner join ii on procedures_icd.subject_id = ii.subject_id and procedures_icd.hadm_id = ii.hadm_id),
k as (select icd_code , icd_version  , avg(outtime - intime) as avg_duration from j 
group by icd_code , icd_version),
rr as (
select j.* , j.outtime - j.intime  as duration , k.avg_duration   from j 
inner join k on k.icd_code = j.icd_code and k.icd_version = j.icd_version),
nice as (
select rr.subject_id  , patients.gender , rr.icd_code , rr.icd_version from rr 
inner join patients on patients.subject_id = rr.subject_id
where duration < avg_duration),
new as (
select distinct * from nice),
kkk as (
select * from new 
order by subject_id , icd_code desc , icd_version desc , gender)
select * from kkk
limit 1000 ;
