with rr as (
select diagnoses_icd.* , d_icd_diagnoses.long_title from diagnoses_icd
inner join d_icd_diagnoses on ( d_icd_diagnoses.icd_code  = diagnoses_icd.icd_code and d_icd_diagnoses.icd_version = diagnoses_icd.icd_version)),
a1 as (
select rr.long_title , admissions.* from admissions
inner join rr on  rr.subject_id = admissions.subject_id and rr.hadm_id = admissions.hadm_id),
a2 as (
select long_title , (sum(hospital_expire_flag)::NUMERIC / count(hospital_expire_flag)) as mortality_frac from a1 
group by long_title
order by mortality_frac desc
limit 245),
a3 as 
(select a1.* from a1 
inner join a2 on a1.long_title = a2.long_title),
a4 as
(select distinct subject_id , long_title from a3
where hospital_expire_flag = '0' ),
a5 as 
(select patients.anchor_age , a4.* from a4 
inner join patients on patients.subject_id = a4.subject_id),
kk as (
select long_title, avg(anchor_age) as survived_avg_age from a5
group by long_title
order by long_title , survived_avg_age desc)
select * from kk ;
