with j as (select subject_id , count(distinct stay_id) as cnt_icu from icustays 
group by subject_id),
k as (select * from j
where cnt_icu >= 5),
dd as (select icustays.* , k.cnt_icu from k 
inner join icustays on icustays.subject_id = k.subject_id),
rr as (select subject_id, avg(outtime - intime) as avg_stay from icustays
group by subject_id),
nice as (select dd.* , rr.avg_stay from dd
inner join rr on rr.subject_id = dd.subject_id),
final as(
select subject_id, cnt_icu, avg_stay from nice
where (first_careunit like '%MICU%' or last_careunit like '%MICU%')) , 
gg as (
select distinct * from final 
order by avg_stay desc, cnt_icu desc , subject_id desc)
select subject_id , cnt_icu as total_stays , avg_stay as avg_length_of_stay from gg
limit 500 ;
