select count(distinct admissions.hadm_id) from labevents
inner join admissions on labevents.hadm_id = admissions.hadm_id and labevents.subject_id = admissions.subject_id
where flag is not null and flag = 'abnormal' and hospital_expire_flag = 1 ;
