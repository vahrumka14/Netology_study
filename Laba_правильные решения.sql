-- a. Вывести список названий департаментов и количество 
--    главных врачей в каждом из этих департаментов
SELECT
	d.name,
    count(distinct(e.chief_doc_id)) as chief_doc_count
FROM Department d
JOIN Employee e ON e.department_id = d.id
GROUP BY d.id, d.name;


-- b. Вывести список департаментов, в которых работают 
--    3 и более сотрудников
--    (id и название департамента, количество сотрудников)
SELECT
    d.id,
	d.name,
    count(e.id) as employee_count
FROM Department d
JOIN Employee e ON e.department_id = d.id
GROUP BY d.id, d.name
HAVING count(e.id) >= 3
ORDER BY d.id;


-- c. Вывести список департаментов с максимальным количеством публикаций
--    (id и название департамента, количество публикаций)
WITH dep_public AS (
	SELECT 
  		d.id,
  		d.name,
  		SUM(e.num_public) AS total_public
	FROM Department d
    JOIN Employee e ON d.id=e.department_id
    GROUP BY d.id, d.name
    ORDER BY total_public DESC
)
SELECT * FROM dep_public
WHERE total_public = (
	SELECT total_public FROM dep_public LIMIT 1
);


-- d. Вывести список сотрудников с минимальным количеством публикаций
--    количеством публикаций в своем департаменте
--    (id и название департамента, имя сотрудника, количество публикаций)
WITH mp AS (
	SELECT
  		MIN(e.num_public) AS num_public,
  		e.department_id
	FROM Employee e
	GROUP BY e.department_id
)
SELECT d.id, d.name, e.name, e.num_public FROM mp
FULL OUTER JOIN Employee e ON e.num_public = mp.num_public
JOIN Department d ON d.id = e.department_id
WHERE d.id = mp.department_id AND e.num_public = mp.num_public
ORDER BY d.id;


-- e. Вывести список департаментов и среднее количество публикаций
--    для тех департаментов, в которых работает более одного главного врача
--    (id и название департамента, среднее количество публикаций)
SELECT
	d.id,
	d.name,
	AVG(e.num_public) AS avg
FROM Department d
JOIN Employee e ON d.id = e.department_id
GROUP BY d.id, d.name
HAVING COUNT(DISTINCT(e.chief_doc_id)) > 1;

Collapse




