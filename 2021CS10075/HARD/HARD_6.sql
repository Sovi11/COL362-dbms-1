with recursive j as (select subject_id , hadm_id, admittime ,dischtime from admissions
order by admittime
limit 500),
k as (select diagnoses_icd.icd_code , diagnoses_icd.icd_version , j.* from diagnoses_icd 
inner join j on diagnoses_icd.subject_id = j.subject_id and diagnoses_icd.hadm_id = j.hadm_id ),
r as (select k1.* , k2.subject_id as sub2 , k2.hadm_id as adm2 , k2.admittime as admittime2 ,k2.dischtime as dischtime2 from k k1
inner join k k2 on k1.icd_code = k2.icd_code and k1.icd_version = k2.icd_version ),
a1 as (
select * from r
where ( subject_id <> sub2 and ((admittime <= admittime2 and dischtime >= admittime2 ) or (admittime2 <= admittime and dischtime2 >= admittime)))),
edges_intermediate as (
    select subject_id as node1 , sub2 as node2 from a1
),
edges as (select distinct * from edges_intermediate),
ShortestPath AS (
    SELECT
        node1,
        node2,
        1 AS path_length
    FROM
        edges
    WHERE
        node1 = 10001725

    UNION ALL

    SELECT
        e.node1,
        e.node2,
        sp.path_length + 1 AS path_length
    FROM
        ShortestPath sp
    JOIN
        edges e ON sp.node2 = e.node1
    WHERE
        sp.path_length < 5 
),
ShortestPathToDestination AS (
    SELECT
        node2,
        path_length
    FROM
        ShortestPath
    WHERE
        node2 = 14370607
)
SELECT
    COALESCE(MIN(path_length), 0) AS pathlength
FROM
    ShortestPathToDestination;
