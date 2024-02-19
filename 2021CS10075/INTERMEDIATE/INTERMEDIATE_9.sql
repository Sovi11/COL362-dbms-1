with j as (select admissions.subject_id , admissions.hadm_id , admissions.admittime ,admissions.dischtime , diagnoses_icd.icd_code from admissions
inner join diagnoses_icd on admissions.subject_id = diagnoses_icd.subject_id and admissions.hadm_id = diagnoses_icd.hadm_id 
where icd_code like 'I21%' ),
kk as 
(select distinct j.subject_id   from j 
inner join admissions a on a.subject_id = j.subject_id and a.hadm_id <> j.hadm_id and j.dischtime <= a.admittime
order by subject_id desc)
select * from kk
limit 1000 ;
