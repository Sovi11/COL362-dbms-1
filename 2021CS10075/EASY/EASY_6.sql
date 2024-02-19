with rr as (
select diagnoses_icd.* , d_icd_diagnoses.long_title from diagnoses_icd
inner join d_icd_diagnoses on ( d_icd_diagnoses.icd_code  = diagnoses_icd.icd_code and d_icd_diagnoses.icd_version = diagnoses_icd.icd_version)),
a1 as (
select rr.long_title , admissions.* from admissions
inner join rr on  rr.subject_id = admissions.subject_id and rr.hadm_id = admissions.hadm_id)
select count(*) from a1 
where long_title = 'Cholera due to vibrio cholerae' ;
