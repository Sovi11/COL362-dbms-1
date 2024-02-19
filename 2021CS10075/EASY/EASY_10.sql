with k as (select p1.subject_id from procedures_icd p1
inner join procedures_icd p2 on p1.subject_id = p2.subject_id and p1.hadm_id <> p2.hadm_id and p1.icd_code = p2.icd_code and p1.icd_version = p2.icd_version),
j as (
select k.* , patients.anchor_age from k 
inner join patients on patients.subject_id = k.subject_id
where patients.anchor_age < 50
order by k.subject_id, anchor_age )
select distinct * from j ;
