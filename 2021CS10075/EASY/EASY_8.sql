with rr as (
select diagnoses_icd.* , d_icd_diagnoses.long_title from diagnoses_icd
inner join d_icd_diagnoses on ( d_icd_diagnoses.icd_code  = diagnoses_icd.icd_code and d_icd_diagnoses.icd_version = diagnoses_icd.icd_version)),
a1 as (
select rr.long_title , icustays.* from icustays
inner join rr on  rr.subject_id = icustays.subject_id and rr.hadm_id = icustays.hadm_id),
a2 as
(select distinct(subject_id) from a1 
where long_title = 'Typhoid fever')
select a2.* , patients.anchor_age from a2 
inner join patients on a2.subject_id = patients.subject_id
order by subject_id , anchor_age ;
