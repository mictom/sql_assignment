
WITH table_a AS (
SELECT 	dimension_1,
		SUM(measure_1) AS measure_1
	FROM TABLE_A
	GROUP BY dimension_1
)

table_b AS (
	SELECT 	dimension_1,
			SUM(measure_2) AS measure_2
	FROM TABLE_B
	GROUP BY dimension_1
),

dim_1_recs AS (
	SELECT dimension_1 FROM table_a
	UNION
	SELECT dimension_1 FROM table_b
)

dim_mapping AS (
	SELECT t_d.dimension_1, t_m.dimension_2
	FROM dim_1_recs t_d
	
	JOIN TABLE_MAP t_m ON t_d.dimension_1 = t_m.dimension_1
),

calc AS (
	SELECT 	dimension_1,
			dimension_2,
			COALESCE(measure_1, 0) AS measure_1,
			COALESCE(measure_2, 0) AS measure_2
	FROM dim_mapping
),

final AS (
	SELECT * FROM calc
)

SELECT * FROM final

