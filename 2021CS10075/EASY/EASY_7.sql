with j as (select pharmacy_id , count(distinct subject_id) as num_patients_visited from prescriptions 
group by pharmacy_id
having count(distinct subject_id) = 1
order by pharmacy_id )
select * from j  ;
