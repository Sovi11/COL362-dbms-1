with k as (select * from diagnoses_icd 
where icd_code = '5723'),
j as (select admissions.* , k.icd_code from admissions 
inner join k on (admissions.subject_id = k.subject_id and admissions.hadm_id = k.hadm_id)),
r as (select subject_id ,count( distinct hadm_id) as diagnosis_count from j
group by subject_id),
rr as (select subject_id ,  count (distinct hadm_id) as total_admissions from admissions
group by subject_id ),
a1 as (select rr.total_admissions ,r.* from rr 
inner join r on r.subject_id = rr.subject_id),
a2 as (select a1.* , patients.gender from a1
inner join patients on patients.subject_id = a1.subject_id),
a3 as (select subject_id , max(admittime)  as last_admission, min(admittime) as first_admission from admissions
group by subject_id),
a4 as (select a2.* , a3.last_admission , a3.first_admission from a2
inner join a3 on a2.subject_id = a3.subject_id),
kk as (
select * from a4
order by total_admissions desc , diagnosis_count desc , last_admission desc , first_admission desc , gender desc , subject_id desc)
select subject_id , gender , total_admissions , last_admission , first_admission , diagnosis_count from kk 
limit 1000 ;

