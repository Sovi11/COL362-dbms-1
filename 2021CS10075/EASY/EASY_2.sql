with j as (select subject_id, count(*) AS num_admissions 
     FROM admissions 
     GROUP BY subject_id )
     select  * from j
     where num_admissions = (select max(num_admissions) from j)
     order by subject_id ;
