with j as (select subject_id , count(hadm_id) as cnt from drgcodes
group by subject_id ),
k as (select distinct subject_id from j
where cnt > 1),
dd as (select drgcodes.*  from drgcodes
inner join k on drgcodes.subject_id = k.subject_id ),
nice as (select * from dd 
where description ilike '%alcoholic%'),
final as (select subject_id , count(description) as diagnoses_count from nice 
group by subject_id),
kk as (select distinct * from final )
select * from kk
order by diagnoses_count desc , subject_id desc ;

