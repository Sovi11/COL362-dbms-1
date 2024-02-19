with j as (select subject_id , drug, count (distinct hadm_id) as num_dist_adms from prescriptions 
group by (subject_id , drug )),
k as (select * from j where num_dist_adms > 1),
kk as (
select k.subject_id , patients.anchor_year, k.drug  from k
inner join patients on patients.subject_id = k.subject_id
order by subject_id desc , anchor_year desc , drug desc)
select * from kk
limit 1000 ;
