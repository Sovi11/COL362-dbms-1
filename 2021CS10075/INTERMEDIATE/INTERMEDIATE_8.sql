with j as (select distinct subject_id, hadm_id, drug from prescriptions
where  drug ilike '%prochlorperazine%' or drug ILIKE '%bupropion%'),
rr as (
select j.* , d.icd_code   from j 
inner join diagnoses_icd d on d.subject_id =j.subject_id and d.hadm_id = j.hadm_id
where d.icd_code like 'V4%' ),
a1 as (
select count (distinct icd_code) as distinct_diagnoses_count , subject_id , hadm_id , drug from rr
group by subject_id , hadm_id , drug
having count (distinct icd_code) > 1)
select subject_id , hadm_id , distinct_diagnoses_count , drug from a1
order by distinct_diagnoses_count desc, subject_id desc, hadm_id desc, drug ;
