with k as (select * from admissions
where (admission_type like 'URGENT'  and hospital_expire_flag =1)),
j as (select diagnoses_icd.* from diagnoses_icd
inner join k on (k.subject_id = diagnoses_icd.subject_id and k.hadm_id = diagnoses_icd.hadm_id))
select d_icd_diagnoses.long_title , j.icd_version , j.icd_code , j.hadm_id , j.subject_id from d_icd_diagnoses
inner join j on (d_icd_diagnoses.icd_code = j.icd_code and d_icd_diagnoses.icd_version = j.icd_version)
order by subject_id desc, hadm_id desc , icd_code desc , long_title desc
limit 1000 ;

