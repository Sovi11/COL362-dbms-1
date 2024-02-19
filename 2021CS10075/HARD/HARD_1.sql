with k as (select subject_id , max(admittime) as max_adm from admissions
group by subject_id),
j as (select admissions.* , k.max_adm from admissions 
inner join k on k.subject_id = admissions.subject_id
where admittime = max_adm),
rr as (
select diagnoses_icd.* , d_icd_diagnoses.long_title from diagnoses_icd
inner join d_icd_diagnoses on ( d_icd_diagnoses.icd_code  = diagnoses_icd.icd_code and d_icd_diagnoses.icd_version = diagnoses_icd.icd_version)),
kk as (select * from rr
where long_title like '%Meningitis%'),
a1 as (
select kk.long_title , j.* from j
inner join kk on  kk.subject_id = j.subject_id and kk.hadm_id = j.hadm_id),
a2 as (select a1.* , patients.gender from a1 
inner join patients on patients.subject_id = a1.subject_id)
select gender , round(100* (sum(hospital_expire_flag)::NUMERIC / count(hospital_expire_flag)),2) as mortality_rate from a2 
group by gender
order by mortality_rate , gender desc ;
