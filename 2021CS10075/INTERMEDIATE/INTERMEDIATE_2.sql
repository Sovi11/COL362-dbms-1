with j as (select prescriptions.drug , prescriptions.starttime ,admissions.* from prescriptions
inner join admissions on prescriptions.subject_id  = admissions.subject_id and prescriptions.hadm_id = admissions.hadm_id),
k as (
select * from j
where (starttime - admittime)<= interval '12 hours' and starttime >= admittime)
select drug ,count(hadm_id) as prescription_count from k 
group by drug
order by prescription_count desc , drug desc
limit 1000 ;
